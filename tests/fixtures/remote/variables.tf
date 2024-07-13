# Input Variables
# https://www.terraform.io/language/values/variables

variable "gke_fleet_host_project_id" {
  type    = string
  default = "test-gke-fleet-host-tf64-sb"
}

variable "google_service_account" {
  type    = string
  default = "plt-lz-testing-github@ptl-lz-terraform-tf91-sb.iam.gserviceaccount.com"
}

variable "project" {
  type    = string
  default = "test-gke-fleet-member-tfc5-sb"
}
