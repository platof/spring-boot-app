locals {
  namespaces = [
    var.app_namespace,
    var.monitoring_namespace
  ]
  name     = "java-app-cluster"
  region   = "us-east-1"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  tags = {
    Project = "eks-cluster"
  }
}