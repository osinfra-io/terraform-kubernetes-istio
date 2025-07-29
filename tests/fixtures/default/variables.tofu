# Input Variables
# https://opentofu.org/docs/language/values/variables

variable "gateway_dns" {
  type = map(object({
    managed_zone = string
    project      = string
  }))
}

variable "project" {
  type = string
}
