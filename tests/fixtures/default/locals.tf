# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  labels = {
    cost-center = "mock-x001"
    env         = "mock-environment"
    repository  = "mock-repository"
    platform    = "mock-platform"
    team        = "mock-team"
  }
}
