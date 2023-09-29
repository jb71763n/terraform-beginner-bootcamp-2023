terraform {
    # Add the Terraform Cloud backend
    #cloud {
    #organization = "jb71763n-3c6553"

    #workspaces {
    #  name = "terra-house"
   # }
  #}

required_providers {
  aws = {
      # Add the Terraform AWS Provider
      source = "hashicorp/aws"
      version = "5.17.0"
  }
}
}
 provider "aws" {
  # Configuration options
}