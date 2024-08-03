# Google Compute Global Address Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address

resource "google_compute_global_address" "istio_gateway_mci" {
  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  labels  = var.labels
  name    = "istio-gateway-mci"
  project = var.project
}

# Google Compute Managed SSL Certificate Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate

# The declarative generation of a Kubernetes ManagedCertificate resource is not supported on
# MultiClusterIngress resources. #36

resource "google_compute_managed_ssl_certificate" "istio_gateway_mci" {
  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  managed {
    domains = local.istio_gateway_domains
  }

  name    = "istio-gateway-mci"
  project = var.project
}

# Google Compute SSL Policy Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy

resource "google_compute_ssl_policy" "default" {
  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  name            = "default"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project
}

# DNS Record Set Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set

resource "google_dns_record_set" "istio_gateway_mci" {
  for_each = var.istio_gateway_dns

  managed_zone = each.value.managed_zone
  name         = "${each.key}."
  project      = each.value.project
  rrdatas      = [google_compute_global_address.istio_gateway_mci[0].address]
  ttl          = 300
  type         = "A"
}
