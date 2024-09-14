# Output Values
# https://www.terraform.io/language/values/outputs

output "gateway_mci_global_address" {
  value = module.test.gateway_mci_global_address
}

output "gateway_mci_ssl_certificate_name" {
  value = module.test.gateway_mci_ssl_certificate_name
}
