# Output Values
# https://www.terraform.io/language/values/outputs

output "istio_gateway_mci_global_address" {
  value = module.test.istio_gateway_mci_global_address
}

output "istio_gateway_mci_ssl_certificate_name" {
  value = module.test.istio_gateway_mci_ssl_certificate_name
}

output "project_id" {
  value = var.project
}
