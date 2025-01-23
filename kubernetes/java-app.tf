#resource "kubernetes_service_account" "java_app_sa" {
#  metadata {
#    name      = "java-app-sa"
#    namespace = var.app_namespace
#    annotations = {
#      "eks.amazonaws.com/role-arn" = aws_iam_role.java_app_role.arn
#    }
#  }
#}

resource "kubernetes_deployment" "java_app" {
  depends_on = [kubernetes_namespace.namespaces, helm_release.mysql, kubernetes_config_map.java_app_config, module.eks]
  metadata {
    name = "java-app"
    labels = {
      app = "java-app"
    }
    namespace = var.app_namespace
  }

  spec {
    replicas = 1


    selector {
      match_labels = {
        app = "java-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "java-app"
        }
      }

      spec {
        container {
          name  = "java-app"
          image = "platof/java-app:latest"
          command = [
            "java",
            "-jar",
            "app.jar",
            "--spring.config.location=/opt/config/application.yaml",
            "--spring.profiles.active=mysql"
          ]

          port {
            container_port = 8080
          }

          volume_mount {
            name       = "java-app-config"
            mount_path = "/opt/config"
          }
          startup_probe {
            http_get {
              path = "/actuator/health"
              port = 8080
            }
            failure_threshold     = 30
            period_seconds        = 20
            initial_delay_seconds = 180
          }
          readiness_probe {
            http_get {
              path = "/actuator/health/readiness"
              port = 8080
            }
            period_seconds    = 10
            failure_threshold = 3
            timeout_seconds   = 10
          }
          liveness_probe {
            http_get {
              path = "/actuator/health/liveness"
              port = 8080
            }
            period_seconds    = 15
            failure_threshold = 3
            timeout_seconds   = 10
          }
        }
        volume {
          name = "java-app-config"

          config_map {
            name = "java-app-config"
          }
        }
      }
    }
  }
}


resource "kubernetes_config_map" "java_app_config" {
  metadata {
    name      = "java-app-config"
    namespace = var.app_namespace
  }

  data = {
    "application.yaml" = <<YAML
    spring:
      application:
        name: app
      datasource:
        username: root
        password: ${random_password.mysql_password.result}
        url: jdbc:mysql://mysql:3306/challenge
        driver-class-name: com.mysql.cj.jdbc.Driver
      flyway:
        url: jdbc:mysql://mysql:3306/challenge
        user: root
        password: ${random_password.mysql_password.result}
        enabled: true
    management:
      endpoints:
        web:
          exposure:
            include: $${ACTUATOR_ENDPOINTS:health,info,prometheus}
    YAML
  }
}

resource "kubernetes_service" "java_app_service" {
  metadata {
    name      = "java-app-service"
    namespace = var.app_namespace
  }
  spec {
    selector = {
      app = "java-app"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
