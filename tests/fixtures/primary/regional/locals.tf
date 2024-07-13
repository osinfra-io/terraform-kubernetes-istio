# Local Values
# https://www.terraform.io/language/values/locals

locals {
  regional = data.terraform_remote_state.regional.outputs
}
