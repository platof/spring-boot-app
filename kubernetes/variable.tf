variable "monitoring_namespace" {
  default     = "monitoring"
  description = "Kubernetes Namespace to Deploy Monitoring Components"
  type        = string
}

variable "app_namespace" {
  default     = "application"
  description = "Kubernetes Namespace to Deploy Application Components"
  type        = string
}

variable "grafana_enabled" {
  default     = true
  type        = bool
  description = "Optional. User can enable Grafana"
}

variable "prometheus_helm_version" {
  default     = "62.1.0"
  description = "Helm Chart Version for Kube Prometheus Stack"
  type        = string
}


variable "storage_class_type" {
  default     = "standard"
  description = "Storage Class to Use for Prometheus Metrics Storage and Grafana"
  type        = string
}


variable "monitoring_hostname" {
  default     = ""
  description = "HostName to Expose Grafana to Internet"
  type        = string
}


variable "grafana_resources" {
  type        = map(any)
  description = "Resources and Limits for Grafana Pod"
  default = {
    cpu_request = "100m"
    mem_request = "300Mi"
    mem_limit   = "500Mi"
  }
}

variable "grafana_storage_size" {
  type        = string
  description = "Storage Configuration map of Size and storage Class to use"
  default     = "10Gi"
}

variable "enable_grafana_storage" {
  type        = bool
  description = "Enable Grafana Storage"
  default     = false
}

variable "prometheus_resource_requests" {
  type        = string
  description = "Resource Request for Prometheus"
  default     = "400Mi"
}

variable "prometheus_storage_size" {
  type        = string
  description = "Size of Prometheus Storage"
  default     = "10Gi"
}

variable "node_exporter_resources" {
  type        = map(any)
  description = "Request and Limits for Node Exporter"
  default = {
    cpu_request = "50m"
    cpu_limit   = "200m"
    mem_request = "50Mi"
    mem_limit   = "200Mi"
  }
}


variable "prom_operator_resources" {
  type        = map(any)
  description = "Request and Limits for Prometheus Operator"
  default = {
    cpu_request = "50m"
    mem_request = "50Mi"
    mem_limit   = "200Mi"
  }
}

variable "kube_state_resources" {
  type        = map(any)
  description = "Request and Limits for Kube-State-Metrics"
  default = {
    cpu_request = "50m"
    mem_request = "50Mi"
    mem_limit   = "200Mi"
  }
}


variable "prometheus_retention_days" {
  type        = string
  description = "Number of Days to Retain Prometheus Metrics"
  default     = "180d"
}

variable "mysql_database" {
  type        = string
  description = "mysql database name"
  default     = "challenge"
}
