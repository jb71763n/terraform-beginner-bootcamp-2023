terraform {
    # Add the Terraform Cloud backend
    #cloud {
    #organization = "jb71763n-3c6553"

    #workspaces {
    #  name = "terra-house"
   # }
  #}

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
provider "random" {
  # Configuration options
}
 provider "aws" {
  # Configuration options
}