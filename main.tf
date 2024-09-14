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
    domains = local.gateway_domains
  }

  name    = "istio-gateway-mci"
  project = var.project
}

# Google Compute Security Policy Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy

resource "google_compute_security_policy" "istio_gateway" {
  provider = google-beta # Required for the adaptive_protection_config auto_deploy_config block

  # Ensure Cloud Armor prevents message lookup in Log4j2
  # checkov:skip=CKV_GCP_73: False positive

  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  adaptive_protection_config {
    auto_deploy_config {

      # Rules are only automatically deployed for alerts on potential attacks with confidence scores greater than this threshold.

      confidence_threshold = "0.5"

      # Google Cloud Armor stops applying the action in the automatically deployed rule to an identified attacker after this duration.

      expiration_sec = 7200

      # Rules are only automatically deployed when the estimated impact to baseline traffic from the suggested mitigation is below this threshold

      impacted_baseline_threshold = "0.01"

      # During an alerted attack, Adaptive Protection identifies new attackers only when the load to the backend service that is under attack exceeds this threshold.

      load_threshold = "0.8"
    }

    layer_7_ddos_defense_config {
      enable = true
    }
  }

  advanced_options_config {
    log_level = "VERBOSE"
  }

  name    = "istio-gateway"
  project = var.project

  rule {
    action   = "throttle"
    preview  = false
    priority = "30000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    rate_limit_options {
      enforce_on_key = "ALL"
      conform_action = "allow"
      exceed_action  = "deny(429)"

      rate_limit_threshold {
        count        = "500"
        interval_sec = "60"
      }
    }

    description = "Rate limit all user IPs"
  }

  rule {
    action      = "allow"
    description = "Default allow rule"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    priority = "2147483647" # Use the maximum allowed priority value to ensure this is the default rule
  }

  dynamic "rule" {
    for_each = local.preconfigured_waf_rules

    content {
      action      = rule.value.action
      description = rule.value.description

      match {
        expr {
          expression = "evaluatePreconfiguredWaf('${rule.value.name}', {'sensitivity': ${rule.value.sensitivity}})"
        }
      }

      priority = rule.value.priority
      preview  = rule.value.preview
    }
  }
}

# Google Compute SSL Policy Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ssl_policy

resource "google_compute_ssl_policy" "istio_gateway" {
  count = var.gke_fleet_host_project_id == "" ? 1 : 0

  name            = "istio-gateway"
  min_tls_version = "TLS_1_2"
  profile         = "MODERN"
  project         = var.project
}

# DNS Record Set Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set

resource "google_dns_record_set" "istio_gateway_mci" {
  for_each = var.gateway_dns

  managed_zone = each.value.managed_zone
  name         = "${each.key}."
  project      = each.value.project
  rrdatas      = [google_compute_global_address.istio_gateway_mci[0].address]
  ttl          = 300
  type         = "A"
}
