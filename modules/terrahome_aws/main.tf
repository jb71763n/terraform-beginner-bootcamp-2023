 terraform {
    required_providers {
        aws = {
            # Add the Terraform AWS Provider
            source = "hashicorp/aws"
            version = "5.17.0"
        }
    }
 }
 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}

