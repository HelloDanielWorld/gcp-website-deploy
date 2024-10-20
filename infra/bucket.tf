# Generate a random 8-digit number for bucket unique name
resource "random_integer" "random_8_digit_number" {
  min = 10000000
  max = 99999999

  lifecycle {
    prevent_destroy = true
  }
}

# Google Cloud Storage bucket for storing Terraform state
resource "google_storage_bucket" "terraform_state" {
  name          = "terraform-state-bucket${random_integer.random_8_digit_number.result}"
  location      = "EU"
  
  versioning {
    enabled = true 
  }
    
  lifecycle {
    prevent_destroy = true
  }
}

# GCS bucket for hosting static website content
resource "google_storage_bucket" "website" {
  name     = "website-by-danielr"
  location = "EU"

  website {
    main_page_suffix = "index.html"
  }
}

# Upload static content (HTML) to the GCS website bucket
resource "google_storage_bucket_object" "static-site" {
  bucket = google_storage_bucket.website.name
  name   = "index.html"
  source = "../website/index.html"
}

# Grant public read access to the uploaded object (HTML-file)
resource "google_storage_object_access_control" "public_site" {
  bucket = google_storage_bucket.website.name
  object = google_storage_bucket_object.static-site.name
  role   = "READER"
  entity = "allUsers"
}
