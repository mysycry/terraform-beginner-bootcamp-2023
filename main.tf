terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "josiasmichael-terraform"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  # cloud {
  #   organization = "josiasmichael-terraform"
  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }  
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token

}

 module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to play MU Online in 2023!!"
  description = <<DESCRIPTION
MU Online is a 3D fantasy-themed massively multiplayer online role-playing game (MMORPG) developed and published by Webzen. The game was originally released in South Korea in 2001 and has since gained popularity in various regions around the world. MU Online is known for its hack-and-slash gameplay, where players create characters, explore a fantasy world, and engage in combat with monsters and other players.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}