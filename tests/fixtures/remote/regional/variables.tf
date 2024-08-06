# Input Variables
# https://www.terraform.io/language/values/variables

variable "environment" {
  type = string
}

variable "istio_control_plane_clusters" {
  type    = string
  default = null
}

variable "istio_external_istiod" {
  type    = bool
  default = false
}

variable "istio_remote_injection_path" {
  type    = string
  default = "/inject"
}

variable "istio_remote_injection_url" {
  type    = string
  default = ""
}

variable "project" {
  type = string
}

variable "region" {
  type = string
}
