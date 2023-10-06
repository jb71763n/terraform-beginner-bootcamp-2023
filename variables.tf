variable "terratowns_endpoint" {
 type = string
}

variable "terratowns_access_token" {
 type = string
}

variable "teacherseat_user_uuid" {
 type = string
}

variable "coffee" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "blues" {
  type = object({
    public_path = string
    content_version = number
  })
}