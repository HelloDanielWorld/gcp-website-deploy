# Backend bucket for serving content from the GCS website bucket
resource "google_compute_backend_bucket" "website-backend" {
  name        = "website-backend"
  bucket_name = google_storage_bucket.website.name
  description = "Contains files for the website"
  enable_cdn  = true
}

# Managed SSL certificate for securing the website with HTTP
resource "google_compute_managed_ssl_certificate" "website" {
  name = "website-cert"
  managed {
    domains = [google_dns_record_set.website-record.name]
  }
}

# URL map to route requests to the backend service (GCS bucket)
resource "google_compute_url_map" "website-map" {
  name            = "website-url-map"
  default_service = google_compute_backend_bucket.website-backend.self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_bucket.website-backend.self_link
  }
}

# HTTPS proxy for handling HTTPS requests
resource "google_compute_target_https_proxy" "website-https-proxy" {
  name               = "website-https-proxy"
  url_map            = google_compute_url_map.website-map.self_link
  ssl_certificates   = [google_compute_managed_ssl_certificate.website.self_link]
}

# Global forwarding rule to direct HTTPS traffic to the HTTPS proxy
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "website-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.website-ip.address
  ip_protocol           = "TCP"
  port_range            = "443"
  target                = google_compute_target_https_proxy.website-https-proxy.self_link
}
