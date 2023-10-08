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
   cloud {
     organization = "josiasmichael-terraform"
     workspaces {
       name = "terra-house-1"
     }
   }
     
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token

}

 module "home_muonline_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.muonline.public_path
  content_version = var.muonline.content_version
}

resource "terratowns_home" "home_muonline" {
  name = "How to play MU Online in 2023!!"
  description = <<DESCRIPTION
MU Online is a 3D fantasy-themed massively multiplayer online role-playing game (MMORPG) developed and published by Webzen. The game was originally released in South Korea in 2001 and has since gained popularity in various regions around the world. MU Online is known for its hack-and-slash gameplay, where players create characters, explore a fantasy world, and engage in combat with monsters and other players.
DESCRIPTION
  domain_name = module.home_muonline_hosting.domain_name
  town = "missingo"
  content_version = var.muonline.content_version
}

module "home_pancitcanton_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.pancitcanton.public_path
  content_version = var.pancitcanton.content_version
}

resource "terratowns_home" "home_pancitcanton" {
  name = "Lucky Me Pancit Canton Recipe"
  description = <<DESCRIPTION
If you’ve never tried experimenting with pancit canton before, this simple recipe is a great start. All you need are fried garlic, butter, fried egg, and spring onion for garnish, and you can make a delicious and filling meal!
DESCRIPTION
  domain_name = module.home_pancitcanton_hosting.domain_name
  town = "missingo"
  content_version = var.pancitcanton.content_version
}