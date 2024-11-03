# Terraform Core Child Module Helpers

locals {
  env = lookup(local.env_map, local.environment, "none")

  environment = (
    terraform.workspace == "default" ?
    "mock-environment" :
    regex(".*-(?P<environment>[^-]+)$", terraform.workspace)["environment"]
  )

  env_map = {
    "non-production" = "nonprod"
    "production"     = "prod"
    "sandbox"        = "sb"
  }

  region = (
    terraform.workspace == "default" ?
    "mock-region" :
    regex("^(?P<region>[^-]+-[^-]+)", terraform.workspace)["region"]
  )

  zone = (
    terraform.workspace == "default" ?
    "mock-zone" :
    (
      regex("^(?P<region>[^-]+-[^-]+)(?:-(?P<zone>[^-]+))?-.*$", terraform.workspace)["zone"] != "" ?
      regex("^(?P<region>[^-]+-[^-]+)(?:-(?P<zone>[^-]+))?-.*$", terraform.workspace)["zone"] :
      null
    )
  )
}
