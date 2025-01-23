resource "kubernetes_namespace" "namespaces" {
  for_each = toset(local.namespaces)
  metadata {
    name = each.value
  }
}