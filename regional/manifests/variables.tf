variable "common_gke_info_virtual_services" {
  description = "The map of Istio VirtualServices to create for GKE Info, that are common among all regions"
  type = map(object({
    destination_host = string
    host             = string
  }))
}

variable "common_virtual_services" {
  description = "The map of Istio VirtualServices to create, that are common among all regions"
  type = map(object({
    destination_host = string
    destination_port = optional(number, 8080)
    host             = string
  }))
}

variable "failover_from_region" {
  description = "The region to fail over from"
  type        = string
  default     = ""
}

variable "failover_to_region" {
  description = "The region to fail over to"
  type        = string
  default     = ""
}

variable "gke_info_virtual_services" {
  description = "The map of Istio VirtualServices to create for GKE Info"
  type = map(object({
    destination_host = string
    host             = string
  }))
}

variable "virtual_services" {
  description = "The map of Istio VirtualServices to create, that are unique to a region"
  type = map(object({
    destination_host = string
    destination_port = optional(number, 8080)
    host             = string
  }))
}
