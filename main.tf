terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
    # Add the Terraform Cloud backend
    cloud {
    organization = "jb71763n-3c6553"

    workspaces {
      name = "terra-house"
    }
  }

}
provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}
module "home_coffee_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.coffee.public_path
  content_version = var.coffee.content_version
}

resource "terratowns_home" "home" {
  name = "Coffee for All 2023!"
  description = <<DESCRIPTION
Coffee is one of the most popular drinks in the world. 
Millons of people can't start the day without it. This is my guide that will
show you the best ways to brew coffee.
DESCRIPTION
  domain_name = module.home_coffee_hosting.domain_name
  town = "cooker-cove"
  content_version = var.coffee.content_version
}

module "home_blues_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.blues.public_path
  content_version = var.blues.content_version
}
resource "terratowns_home" "home" {
  name = "Home of Blues"
  description = <<DESCRIPTION
Blues is a music genre and musical form that originated in the Deep South of the United States around the 1860s. 
Early recordings by artists like Blind Lemon Jefferson, Charlie Patton, Robert Johnson and other artists of the 1920-1930s were collected by John Avery Lomax, Alan Lomax, and Ruby Terrill Lomax, between 1934 and ca. 1950 and now comprise the Archive of American Folk-Song. This is my guide to the world of early Blues music.
DESCRIPTION
  domain_name = module.home_blues_hosting.domain_name
  town = "melomaniac-mansion"
  content_version = var.blues.content_version
}