locals {
  azure_annotations = {
    "service.beta.kubernetes.io/azure-load-balancer-internal" = "true"
  }
  gcp_annotations = {

  }
  additional_ingress_annotations = merge(
    try(var.instance.spec.authenticated, false) == true ? {
      "nginx.ingress.kubernetes.io/auth-realm" : "Authentication required"
      "nginx.ingress.kubernetes.io/auth-secret" : kubernetes_secret.ingress-auth[0].metadata[0].name
      "nginx.ingress.kubernetes.io/auth-type" : "basic"
    } : {},
    try(var.instance.spec.grpc, false) == true ? {
      "nginx.ingress.kubernetes.io/backend-protocol" : "GRPC"
    } : {}
  )
  annotations = merge(local.azure_annotations, local.gcp_annotations,
    try(var.instance.spec.internal, false) == true ? {
      "cloud.google.com/load-balancer-type"                          = "Internal"
      "networking.gke.io/internal-load-balancer-allow-global-access" = "true"
      "networking.gke.io/load-balancer-type"                         = "Internal"
    } : {}
  )

  instance_values = {
    service = {
      annotations = local.annotations
    }
    "controller" : {
      "ingressClass" : var.instance_name,
      "extraEnvs" : [
        {
          "name" : "TZ",
          "value" : var.inputs.cluster.commonEnvironmentVariables["TZ"]
        }
      ],
      "extraArgs" : {
        "default-ssl-certificate" : "default/${kubernetes_secret.cert-secret.metadata.0.name}",
        "enable-ssl-chain-completion" : "true"
      },
      "proxySetHeaders" : {
        "FACETS-REQUEST-ID" : "$request_id"
      }
    }
  }

  ingressDetails = {for k, v in flatten(var.instance.spec.domains) : k => v}
  ingressRoutes  = {for x, y in flatten(var.instance.spec.rules) : x => y}

  instance_temp = var.instance["composition"]["helm_ingress"]
  # merging problem
}

module "helm_ingress" {
  source   = "../../helm/0.1/"
  inputs   = var.inputs
  instance = merge(var.instance["composition"]["helm_ingress"], {
    "spec" = {
      "values"    = instance_values
      "namespace" = var.namespace
    }
  })
  cc_metadata   = var.cc_metadata
  infra         = var.infra
  instance_name = var.instance_name+ "_helm_ingress"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}
resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "rohit.raveendran@capillarytech.com"
}
resource "acme_certificate" "certificate" {
  count                     = try(var.instance.spec.internal, false) == true? 0 : 1
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = "${var.instance_name}-${var.namespace}.${var.cc_metadata.tenant_base_domain}"
  subject_alternative_names = [
    "*.${var.instance_name}-${var.namespace}.${var.cc_metadata.tenant_base_domain}"
  ]
  min_days_remaining = 30
  dns_challenge {
    provider = "route53"
  }
  recursive_nameservers = [
    "8.8.8.8:53"
  ]
}
# certificate stored in k8s secret
resource "kubernetes_secret" "cert-secret" {
  metadata {
    name      = "ingress-cert-${var.instance_name}"
    namespace = var.namespace
  }
  data = {
    "tls.crt" = "${acme_certificate.certificate[0].certificate_pem}${acme_certificate.certificate[0].issuer_pem}"
    "tls.key" = acme_certificate.certificate[0].private_key_pem
    "ca.crt"  = acme_certificate.certificate[0].issuer_pem
  }
  type = "kubernetes.io/tls"
}
# secret with the auth details
resource "kubernetes_secret" "ingress-auth" {
  count = try(var.instance.spec.authenticated, false)? 1 : 0
  metadata {
    name      = "${var.instance_name}-ingress-auth"
    namespace = var.namespace
  }
  data = {
    auth = "${var.instance_name}user:${bcrypt(random_string.basic-auth-pass[0].result)}"
  }
}
# generate password
resource "random_string" "basic-auth-pass" {
  count   = try(var.instance.spec.authenticated, false)? 1 : 0
  length  = 10
  special = false
}
# Route53 entry
data kubernetes_service "nginx-ingress-ctlr" {
  depends_on = [
    module.helm_ingress
  ]
  metadata {
    name      = "${var.instance_name}-ingress-ctlr-nginx-ingress-controller"
    namespace = "default"
  }
}
data "aws_route53_zone" "base-domain-zone" {
  name     = var.cc_metadata.tenant_base_domain
  provider = aws.tooling
}
# cloud wise handling for cname/ a
resource "aws_route53_record" "cluster-base-domain" {
  depends_on = [
    module.helm_ingress
  ]
  zone_id = try(data.aws_route53_zone.base-domain-zone.zone_id, "NA")
  name    = "${var.instance_name}-${var.namespace}.${var.cc_metadata.tenant_base_domain}"
  type    = "A"
  ttl     = "300"
  records = [
    data.kubernetes_service.nginx-ingress-ctlr.status.0.load_balancer.0.ingress.0.ip
  ]
  provider = aws.tooling
}
resource "aws_route53_record" "cluster-base-domain-wildcard" {
  depends_on = [
    module.helm_ingress
  ]
  zone_id = try(data.aws_route53_zone.base-domain-zone.zone_id, "NA")
  name    = "*.${var.instance_name}-${var.namespace}.${var.cc_metadata.tenant_base_domain}"
  type    = "A"
  ttl     = "300"
  records = [
    data.kubernetes_service.nginx-ingress-ctlr.status.0.load_balancer.0.ingress.0.ip
  ]
  provider = aws.tooling
}


resource "kubernetes_ingress_v1" "example_ingress" {
  depends_on = [
    module.helm_ingress, aws_route53_record.cluster-base-domain
  ]
  metadata {
    name        = var.instance.metadata.name
    annotations = var.instance.metadata.annotations
    namespace = var.namespace
  }
  spec {
    ingress_class_name = var.instance_name
    dynamic "rule" {
      for_each = local.ingressDetails
      content {
        host = rule.value.domain
        http {
          dynamic "path" {
            for_each = local.ingressRoutes
            content {
              path      = path.value.path
              path_type = "Prefix"
              backend {
                service {
                  name = path.value.serviceName
                  port {
                    # name   = path.value.portName
                    number = path.value.port
                  }
                }
              }
            }
          }
        }
      }
    }
    dynamic "tls" {
      for_each = local.ingressDetails
      content {
        hosts       = tolist([tls.value.domain])
        secret_name = tls.value.certificateReference
      }
    }
  }
}
