resource "helm_release" "facets_helm" {
  chart            = var.instance.spec["chart"]
  name             = var.instance_name
  namespace        = var.namespace
  timeout          = var.instance.spec["timeout"]
  create_namespace = var.instance.spec["create_namespace"]
  wait             = var.instance.spec["wait"]
  repository       = var.instance.spec["repository"]
  version          = var.instance.spec["version"]
  recreate_pods    = var.instance.spec["recreate_pods"]
  atomic           = var.instance.spec["atomic"]
  values           = var.instance.spec["values"]
}