variable "artifact_registry" {
  description = "The registry to pull the images from"
  type        = string
  default     = "us-docker.pkg.dev/plt-lz-services-tf79-prod/platform-docker-virtual"
}

variable "cluster_prefix" {
  description = "Prefix for your cluster name"
  type        = string
}

variable "enable_istio_gateway" {
  description = "Enable the Istio gateway, used for ingress traffic into the mesh"
  type        = bool
  default     = false
}

variable "environment" {
  description = "The environment must be one of `sandbox`, `non-production`, `production`"
  type        = string
  default     = "sandbox"

  validation {
    condition     = contains(["mock-environment", "sandbox", "non-production", "production"], var.environment)
    error_message = "The environment must be one of `mock-environment` for tests or `sandbox`, `non-production`, or `production`."
  }
}

variable "gateway_autoscale_min" {
  description = "The minimum number of gateway replicas to run"
  type        = number
  default     = 1
}

variable "istio_chart_repository" {
  description = "The repository to pull the Istio Helm chart from"
  type        = string
  default     = "https://istio-release.storage.googleapis.com/charts"
}

variable "istio_control_plane_clusters" {
  description = "The GKE clusters that will be used as Istio control planes"
  type        = string
  default     = null
}

variable "istio_gateway_cpu_request" {
  description = "The CPU request for the Istio gateway"
  type        = string
  default     = "100m"
}

variable "istio_gateway_cpu_limit" {
  description = "The CPU limit for the Istio gateway"
  type        = string
  default     = "2000m"
}

variable "istio_gateway_dns" {
  description = "Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource"
  type = map(object({
    managed_zone = string
    project      = string
  }))
  default = {}
}

variable "istio_gateway_mci_global_address" {
  description = "The IP address for the Istio Gateway multi-cluster ingress"
  type        = string
  default     = ""
}

variable "istio_gateway_memory_request" {
  description = "The memory request for the Istio gateway"
  type        = string
  default     = "128Mi"
}

variable "istio_gateway_memory_limit" {
  description = "The memory limit for the Istio gateway"
  type        = string
  default     = "1024Mi"
}

variable "istio_pilot_autoscale_min" {
  description = "The minimum number of Istio pilot replicas to run"
  type        = number
  default     = 1
}

variable "istio_pilot_cpu_request" {
  description = "The CPU request for the Istio pilot"
  type        = string
  default     = "500m"
}

variable "istio_pilot_cpu_limit" {
  description = "The CPU limit for the Istio pilot"
  type        = string
  default     = "1000m"
}

variable "istio_pilot_memory_request" {
  description = "The memory request for the Istio pilot"
  type        = string
  default     = "2048Mi"
}

variable "istio_pilot_memory_limit" {
  description = "The memory limit for the Istio pilot"
  type        = string
  default     = "4096Mi"
}

variable "istio_pilot_replica_count" {
  description = "The number of Istio pilot replicas to run"
  type        = number
  default     = 1
}

variable "istio_proxy_cpu_request" {
  description = "The CPU request for the Istio proxy"
  type        = string
  default     = "100m"
}

variable "istio_proxy_cpu_limit" {
  description = "The CPU limit for the Istio proxy"
  type        = string
  default     = "2000m"
}

variable "istio_proxy_memory_request" {
  description = "The memory request for the Istio proxy"
  type        = string
  default     = "128Mi"
}

variable "istio_proxy_memory_limit" {
  description = "The memory limit for the Istio proxy"
  type        = string
  default     = "1024Mi"
}

variable "istio_version" {
  description = "The version of istio to install"
  type        = string
  default     = "1.23.0"
}

variable "labels" {
  description = "A map of key/value pairs to assign to the resources being created"
  type        = map(string)
  default     = {}
}

variable "multi_cluster_service_clusters" {
  description = "List of clusters to be included in the MultiClusterService"
  type = list(object({
    link = string
  }))
  default = []
}

variable "node_location" {
  description = "The zone in which the cluster's nodes should be located. If not specified, the cluster's nodes are located across zones in the region"
  type        = string
  default     = null
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "region" {
  description = "The region in which the resource belongs"
  type        = string
}
