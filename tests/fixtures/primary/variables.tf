# Input Variables
# https://www.terraform.io/language/values/variables

variable "dns_project_id" {
  type    = string
  default = "test-default-tf75-sb"
}

variable "google_service_account" {
  type    = string
  default = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"
}

variable "istio_gateway_domain" {
  description = "The top level domain for the Istio gateway"
  type        = string
  default     = "test.gcp.osinfra.io"
}

variable "project" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}
