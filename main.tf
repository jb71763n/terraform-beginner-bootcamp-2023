

terraform {
    # Add the Terraform Cloud backend
    cloud {
    organization = "jb71763n-3c6553"

    workspaces {
      name = "terra-house"
    }
  }
  required_providers {
    # Add the Terraform Random Provider
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      # Add the Terraform AWS Provider
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs
provider "random" {
  # Configuration options
}
resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  lower            = true
  upper            = false
}

 provider "aws" {
  # Configuration options
}
 resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

output "random_bucket_name" {
    value = random_string.bucket_name.result

}