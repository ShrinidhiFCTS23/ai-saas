locals {
  input = {
    xyx = "shujsd"
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
}