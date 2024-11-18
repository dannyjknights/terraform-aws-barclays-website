terraform {
  cloud {
    organization = "danny-hashicorp"
    workspaces {
      name = "barclays-roadshow"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.17.1"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">=2.3.2"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}