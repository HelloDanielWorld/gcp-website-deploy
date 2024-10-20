# Terraform Google Cloud Static Website with Load Balancer

## Project Overview

This project automates the deployment of a static website hosted on Google Cloud Storage (GCS) with an HTTPS load balancer, managed DNS, and SSL certificates using Terraform. The setup includes:

1. A Google Cloud Storage bucket for hosting static content (HTML).
2. A Google Compute Global Static IP address for the website.
3. Google Cloud DNS for managing domain records (e.g., `website.daniel-devops.com`).
4. A Google Cloud Load Balancer for distributing traffic to the backend.
5. SSL certificates to enable HTTPS traffic with a Google-managed certificate.
6. Terraform state is stored in a Google Cloud Storage bucket for state management.

## Infrastructure Architecture

- **GCS Bucket for Terraform State:** A secure storage bucket with object versioning enabled is created to store the Terraform state file.
- **GCS Bucket for Static Website:** A public bucket that hosts the static website content (HTML, CSS, JS) is set up. It serves the `index.html` page.
- **Global Static IP:** A static IP is reserved for routing requests via the load balancer.
- **Google Cloud DNS:** A DNS managed zone is pre-configured, and a DNS A record is created to point to the website's IP.
- **Load Balancer:** A global load balancer is configured with CDN capabilities to improve performance. It forwards traffic via HTTPS to the static website bucket.
- **SSL Certificates:** Managed SSL certificates are automatically created and managed by Google Cloud for the domain to ensure secure HTTPS traffic.
