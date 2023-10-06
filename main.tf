terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}
provider "terratowns" {
  endpoint = "https://terratowns.cloud/api"
  user_uuid = "ea0e39b4-1a37-4967-8053-122a620913ef"
  token = "c21ed203-80bc-4e9d-aca9-eb006b88a5e1"
}
#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
  #bucket_name = var.bucket_name
 # error_html_filepath = var.error_html_filepath
 # index_html_filepath = var.index_html_filepath
 # content_version = var.content_version
 # assets_path = var.assets_path
#}

resource "terratowns_home" "home" {
  name = "Coffee for All 2023!"
  description = <<DESCRIPTION
Coffee is one of the most popular drinks in the world. 
Millons of people can't start the day without it. This is my guide that will
show you the best ways to brew coffee.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "cooker-cove"
  content_version = 1
}