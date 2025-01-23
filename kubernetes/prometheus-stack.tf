resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


resource "kubernetes_secret" "grafana_password" {
  metadata {
    name      = "grafana-admin-secret"
    namespace = var.monitoring_namespace
  }

  data = {
    admin-user     = "admin"
    admin-password = random_password.password.result
  }
  depends_on = [kubernetes_namespace.namespaces, module.eks]
}

# Deploy Prometheus and Grafana via Helm charts
resource "helm_release" "prometheus_operator" {
  name             = "kube-prometheus-stack"
  chart            = "kube-prometheus-stack"
  version          = var.prometheus_helm_version
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = var.monitoring_namespace
  timeout = 600
  cleanup_on_fail  = true
  create_namespace = true

  values = [templatefile(
    "${path.cwd}/files/prometheus.yaml", {
      grafana_enabled: var.grafana_enabled
      STORAGE_CLASS : var.storage_class_type,
      grafana_resources : var.grafana_resources,
      prom_operator_resources : var.prom_operator_resources,
      kube_state_resources : var.kube_state_resources,
      node_exporter_resources : var.node_exporter_resources,
      prometheus_resource_requests : var.prometheus_resource_requests,
      storage_class_type : var.storage_class_type,
      prometheus_storage_size : var.prometheus_storage_size,
      prometheus_retention_days : var.prometheus_retention_days,
      grafana_storage_size : var.grafana_storage_size,
      enable_grafana_storage : var.enable_grafana_storage,
  })]
  depends_on = [kubernetes_secret.grafana_password]
}







