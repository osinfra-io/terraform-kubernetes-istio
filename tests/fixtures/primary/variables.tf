# Input Variables
# https://www.terraform.io/language/values/variables

variable "environment" {
  type = string
}

variable "istio_gateway_dns" {
  type = map(object({
    managed_zone = string
    project      = string
  }))
}

variable "project" {
  type = string
}
