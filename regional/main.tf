# Google Compute Global Address Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address

resource "google_compute_global_address" "istio_gateway" {
  count = var.enable_istio_gateway ? 1 : 0


  labels  = var.labels
  name    = "istio-gateway-${module.helpers.region}"
  project = var.project
}

# DNS Record Set Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set

resource "google_dns_record_set" "istio_gateway" {
  for_each = var.gateway_dns

  managed_zone = each.value.managed_zone
  name         = "${each.key}."
  project      = each.value.project
  rrdatas      = [google_compute_global_address.istio_gateway[0].address]
  ttl          = 300
  type         = "A"
}

# Helm Release
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

resource "helm_release" "base" {
  chart      = "base"
  name       = "base"
  namespace  = "istio-system"
  repository = var.chart_repository

  version = var.istio_version
}

resource "helm_release" "istiod" {
  chart      = "istiod"
  name       = "istiod"
  namespace  = "istio-system"
  repository = var.chart_repository

  dynamic "set" {
    for_each = local.istiod_helm_values
    content {
      name  = set.key
      value = set.value
    }
  }

  values = [
    file("${path.module}/helm/istiod.yml")
  ]

  version = var.istio_version

  depends_on = [
    helm_release.base
  ]
}

resource "helm_release" "gateway" {
  count = var.enable_istio_gateway ? 1 : 0

  chart      = "gateway"
  name       = "gateway"
  namespace  = "istio-ingress"
  repository = var.chart_repository

  dynamic "set" {
    for_each = local.gateway_helm_values
    content {
      name  = set.key
      value = set.value
    }
  }

  values = [
    file("${path.module}/helm/gateway.yml")
  ]

  version = var.istio_version

  depends_on = [
    helm_release.istiod
  ]
}

# Kubernetes Ingress Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1

resource "kubernetes_ingress_v1" "istio_gateway" {
  count = var.enable_istio_gateway ? 1 : 0

  metadata {
    name      = "istio-gateway"
    namespace = "istio-ingress"

    annotations = {
      "kubernetes.io/ingress.allow-http"            = "false"
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.istio_gateway[0].name
      "networking.gke.io/v1beta1.FrontendConfig"    = kubernetes_manifest.istio_gateway_frontendconfig[0].manifest.metadata.name
      "networking.gke.io/managed-certificates"      = kubernetes_manifest.istio_gateway_managed_certificate[0].manifest.metadata.name
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "gateway"
              port {
                number = 443
              }
            }
          }
        }
      }
    }
  }

  wait_for_load_balancer = true

  depends_on = [
    helm_release.gateway
  ]
}


# Kubernetes Manifest Resource
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest

resource "kubernetes_manifest" "istio_gateway_backendconfig" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "cloud.google.com/v1"
    kind       = "BackendConfig"
    metadata = {
      name      = "istio-gateway-backend"
      namespace = "istio-ingress"
    }
    spec = {
      healthCheck = {
        checkIntervalSec   = "5"
        healthyThreshold   = "1"
        port               = "15021"
        requestPath        = "/healthz/ready"
        timeoutSec         = "3"
        type               = "HTTP"
        unhealthyThreshold = "2"
      }
      securityPolicy = {
        name = "istio-gateway"
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_frontendconfig" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"
    metadata = {
      name      = "istio-gateway-frontend"
      namespace = "istio-ingress"
    }
    spec = {
      sslPolicy = "istio-gateway"
      redirectToHttps = {
        enabled = true
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_managed_certificate" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"
    metadata = {
      name      = "istio-gateway-tls"
      namespace = "istio-ingress"
    }
    spec = {
      domains = local.gateway_domains
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_mcs" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "MultiClusterService"

    metadata = {
      name      = "istio-gateway-mcs"
      namespace = "istio-ingress"
      annotations = {
        "cloud.google.com/backend-config" = jsonencode({ "default" = "${kubernetes_manifest.istio_gateway_backendconfig[0].manifest.metadata.name}" })
        "cloud.google.com/neg"            = jsonencode({ "ingress" = true })
        "networking.gke.io/app-protocols" = jsonencode({ "https" = "HTTPS" })
      }
    }

    spec = {
      template = {
        spec = {
          selector = {
            app   = "gateway"
            istio = "gateway"
          }

          ports = [
            {
              name       = "https"
              port       = 443
              protocol   = "TCP"
              targetPort = 443
            }
          ]
        }
      }

      clusters = var.multi_cluster_service_clusters
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_mci" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "MultiClusterIngress"

    metadata = {
      name      = "istio-gateway-mci"
      namespace = "istio-ingress"
      annotations = {
        "networking.gke.io/frontend-config"  = kubernetes_manifest.istio_gateway_frontendconfig[0].manifest.metadata.name
        "networking.gke.io/pre-shared-certs" = "istio-gateway-mci"
        "networking.gke.io/static-ip"        = var.gateway_mci_global_address
      }
    }

    spec = {
      template = {
        spec = {
          backend = {
            serviceName = kubernetes_manifest.istio_gateway_mcs[0].manifest.metadata.name
            servicePort = kubernetes_manifest.istio_gateway_mcs[0].manifest.spec.template.spec.ports[0].port
          }
          rules = [
            {
              http = {
                paths = [
                  {
                    backend = {
                      serviceName = kubernetes_manifest.istio_gateway_mcs[0].manifest.metadata.name
                      servicePort = kubernetes_manifest.istio_gateway_mcs[0].manifest.spec.template.spec.ports[0].port
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_ca_certificate" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"

    metadata = {
      name      = "istio-ca"
      namespace = "istio-ingress"
    }

    spec = {
      isCA = true

      issuerRef = {
        name  = kubernetes_manifest.istio_gateway_intermediate_ca_issuer[0].manifest.metadata.name
        kind  = "Issuer"
        group = "cert-manager.io"
      }

      commonName = "istio-intermediate-ca.osinfra.io"
      duration   = "720h"


      privateKey = {
        algorithm = "ECDSA"
        size      = 256
      }

      secretName = "istio-ca"

      subject = {
        organizations = ["Open Source Infrastructure (as Code) Istio Gateway Intermediate CA"]
      }
    }
  }
}



resource "kubernetes_manifest" "istio_gateway_tls" {
  count = var.enable_istio_gateway ? 1 : 0
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"

    metadata = {
      name      = "istio-gateway-tls"
      namespace = "istio-ingress"
    }

    spec = {
      commonName = "istio-gateway.osinfra.io"
      dnsNames   = ["*"]
      duration   = "720h"
      isCA       = false

      issuerRef = {
        name  = kubernetes_manifest.istio_gateway_intermediate_ca_issuer[0].manifest.metadata.name
        kind  = "Issuer"
        group = "cert-manager.io"
      }

      privateKey = {
        algorithm = "ECDSA"
        size      = 256
      }

      secretName = "istio-gateway-tls"

      subject = {
        organizations = ["Open Source Infrastructure (as Code) Istio Gateway"]
      }
    }
  }
}

resource "kubernetes_manifest" "istio_gateway_intermediate_ca_issuer" {
  count = var.enable_istio_gateway ? 1 : 0

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"

    metadata = {
      name      = "istio-intermediate-ca"
      namespace = "istio-ingress"
    }

    spec = {
      ca = {
        secretName = kubernetes_secret_v1.istio_cert_manager_ca[0].metadata[0].name
      }
    }
  }
}


resource "kubernetes_secret_v1" "istio_cert_manager_ca" {
  count = var.enable_istio_gateway ? 1 : 0

  metadata {
    name      = "cert-manager-ca"
    namespace = "istio-ingress"
  }

  data = {
    "tls.crt" = var.tls_self_signed_cert_cert_manager_root_cert
    "tls.key" = var.tls_self_signed_cert_cert_manager_root_key
  }
}
