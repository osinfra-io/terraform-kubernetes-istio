# Output Values
# https://www.terraform.io/language/values/outputs

output "istio_gateway_mci_global_address" {
  description = "The IP address for the Istio Gateway multi-cluster ingress"
  value       = var.gke_fleet_host_project_id == "" ? google_compute_global_address.istio_gateway_mci[0].address : ""
}

output "istio_gateway_mci_ssl_certificate_name" {
  description = "The name of the SSL certificate for the Istio Gateway multi-cluster ingress"
  value       = var.gke_fleet_host_project_id == "" ? google_compute_managed_ssl_certificate.istio_gateway_mci[0].name : ""
}
