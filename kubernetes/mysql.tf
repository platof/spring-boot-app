resource "helm_release" "mysql" {
  name       = "mysql"
  depends_on = [module.eks, kubernetes_namespace.namespaces]
  namespace  = var.app_namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"
  version    = "11.1.17"

  values = [templatefile(
    "${path.cwd}/files/mysql.yaml",
    {
      mysqlRootPassword = random_password.mysql_password.result,
      mysqlDatabase     = var.mysql_database
    }
  )]
}

resource "random_password" "mysql_password" {
  length  = 16
  special = false
}