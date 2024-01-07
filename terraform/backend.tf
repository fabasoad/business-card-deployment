terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "remote" {
    organization = "fabasoad"

    workspaces {
      name = "business-card"
    }
  }
  required_version = ">= 1.0.4"
}
