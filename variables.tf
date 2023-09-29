variable "user_uuid" {
  description = "User UUID"
  
  type = string

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "user_uuid must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}
variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  
  type = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]{3,63}$", var.bucket_name))
    error_message = "bucket_name must be a valid AWS S3 bucket name (3-63 characters, letters, numbers, hyphens, and periods allowed)"
  }
}
