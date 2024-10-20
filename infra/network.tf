# Global static IP for the load balancer
resource "google_compute_global_address" "website-ip" {
  name = "website-lb-ip"
}

# Fetch the DNS managed zone for the domain, predefined resource
data "google_dns_managed_zone" "dns_zone" {
  name    = "daniel-devops-com"
  project = var.gcp_project
}

# Create a DNS A record to point the domain to the website's IP address
resource "google_dns_record_set" "website-record" {
  name         = "website.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  rrdatas      = [google_compute_global_address.website-ip.address]
}