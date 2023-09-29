terraform {
    # Add the Terraform Cloud backend
    #cloud {
    #organization = "jb71763n-3c6553"

    #workspaces {
    #  name = "terra-house"
   # }
  #}


}

module "terrahouse_aws" {
  source = "./Modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}