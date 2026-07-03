terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.53.0"
    }
  }
  backend "remote" {
    organization = "fabasoad"

    workspaces {
      name = "business-card"
    }
  }
  required_version = ">= 1.15.0"
}
