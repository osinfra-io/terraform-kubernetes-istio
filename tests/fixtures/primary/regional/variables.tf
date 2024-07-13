# Input Variables
# https://www.terraform.io/language/values/variables

variable "dns_project_id" {
  type    = string
  default = "test-default-tf75-sb"
}

variable "project" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}

variable "region" {
  type    = string
  default = "us-east1"
}
