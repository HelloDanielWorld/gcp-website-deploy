# Output the name of the Terraform state bucket nem, used for backend later, since value most be static. 
output "bucket_name" {
  value = google_storage_bucket.terraform_state.name
}

# Output the final website adress 
output "name" {
  value = google_dns_record_set.website-record.name
}