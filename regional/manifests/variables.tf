variable "common_gke_info_istio_virtual_services" {
  description = "The map of Istio VirtualServices to create for GKE Info, that are common among all regions"
  type = map(object({
    destination_host = string
    host             = string
  }))
}

variable "common_istio_virtual_services" {
  description = "The map of Istio VirtualServices to create, that are common among all regions"
  type = map(object({
    destination_host = string
    destination_port = optional(number, 8080)
    host             = string
  }))
}

variable "environment" {
  description = "The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production)"
  type        = string
  default     = "sb"
}

variable "gke_info_istio_virtual_services" {
  description = "The map of Istio VirtualServices to create for GKE Info"
  type = map(object({
    destination_host = string
    host             = string
  }))
}

variable "istio_failover_from_region" {
  description = "The region to failover from"
  type        = string
  default     = ""
}

variable "istio_failover_to_region" {
  description = "The region to failover to"
  type        = string
  default     = ""
}

variable "istio_virtual_services" {
  description = "The map of Istio VirtualServices to create, that are unique to a region"
  type = map(object({
    destination_host = string
    destination_port = optional(number, 8080)
    host             = string
  }))
}
