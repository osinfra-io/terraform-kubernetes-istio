# Input Variables
# https://www.terraform.io/language/values/variables

variable "gateway_dns" {
  description = "Map of attributes for the Istio gateway domain names, it is also used to create the managed certificate resource"
  type = map(object({
    managed_zone = string
    project      = string
  }))
  default = {}
}

variable "gke_fleet_host_project_id" {
  type        = string
  description = "The project ID of the GKE Hub host project"
  default     = ""
}

variable "helpers_cost_center" {
  description = "The cost center the resources will be billed to, must start with 'x' followed by three or four digits"
  type        = string
}

variable "helpers_data_classification" {
  description = "The data classification of the resources can be public, internal, or confidential"
  type        = string
}

variable "helpers_email" {
  description = "The email address of the team responsible for the resources"
  type        = string
}

variable "helpers_repository" {
  description = "The repository name (should be in the format 'owner/repo' containing only lowercase alphanumeric characters or hyphens)"
  type        = string
}

variable "helpers_team" {
  description = "The team name (should contain only lowercase alphanumeric characters and hyphens)"
  type        = string
}

variable "labels" {
  description = "A map of key/value pairs to assign to the resources being created"
  type        = map(string)
  default     = {}
}

variable "project" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}
