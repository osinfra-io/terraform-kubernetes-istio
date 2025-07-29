# Output Values
# https://opentofu.org/docs/language/values/outputs

output "gateway_ip" {
  description = "The IP address of the Istio Gateway"
  value       = var.enable_istio_gateway ? google_compute_global_address.istio_gateway[0].address : null
}
