output "bucket_name" {
    description = "bucket name for our static website hosting"
    value = module.terrahouse_aws.bucket_name
}
output "website_endpoint" {
    description = "bucket endpoint for static website hosting"
    value = module.terrahouse_aws.website_endpoint
}