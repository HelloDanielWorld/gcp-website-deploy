# Backend configuration for storing Terraform state in GCS
terraform {
  backend "gcs" {
    bucket      = "terraform-state-bucket44818628"
    credentials = "../access/project1-access.json"
  }
}