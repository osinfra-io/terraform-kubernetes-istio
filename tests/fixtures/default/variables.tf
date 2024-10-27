# Input Variables
# https://www.terraform.io/language/values/variables

variable "gateway_dns" {
  type = map(object({
    managed_zone = string
    project      = string
  }))
}

variable "helpers_cost_center" {
  type = string
}

variable "helpers_data_classification" {
  type = string
}

variable "helpers_email" {
  type = string
}

variable "helpers_repository" {
  type = string
}

variable "helpers_team" {
  type = string
}

variable "project" {
  type = string
}
