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
  description = "The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production)"
  type        = string
  default     = "sb"
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

variable "istio_config_cluster" {
  description = "Boolean to configure a remote cluster as the config cluster for an external istiod"
  type        = bool
  default     = false
}

variable "istio_external_istiod" {
  description = "Boolean to configure a remote cluster data plane controlled by an external istiod"
  type        = bool
  default     = false
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

variable "istio_remote_injection_path" {
  description = "The sidecar injector mutating webhook configuration path value for the clientConfig.service field"
  type        = string
  default     = "/inject"
}

variable "istio_remote_injection_url" {
  description = "The sidecar injector mutating webhook configuration clientConfig.url value"
  type        = string
  default     = ""
}

variable "istio_version" {
  description = "The version of istio to install"
  type        = string
  default     = "1.22.2"
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
  description = "The region to deploy the resources into"
  type        = string
}
