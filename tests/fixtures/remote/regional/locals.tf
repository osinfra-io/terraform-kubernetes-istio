# Local Values
# https://www.terraform.io/language/values/locals

locals {
  labels = {
    cost-center = "mock-x001"
    env         = var.environment
    repository  = "mock-repository"
    platform    = "mock-platform"
    team        = "mock-team"
  }

  regional = data.terraform_remote_state.regional.outputs

}
