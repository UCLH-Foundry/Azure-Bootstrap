# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  required_version = "1.3.7"

  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "3.47.0"
    }
  }

  backend "local" {
    path = "terraform.prod.tfstate"
  }
}
