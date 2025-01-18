# Input Variables
# https://www.terraform.io/language/values/variables

variable "common_istio_test_virtual_services" {
  description = "The map of Istio VirtualServices to create for Istio testing, that are common among all regions"
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

variable "istio_test_virtual_services" {
  description = "The map of Istio VirtualServices to create for Istio testing"
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
