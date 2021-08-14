provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "personal:app"        = var.app_name
      "personal:deployment" = "tf"
      "personal:env"        = var.environment
    }
  }
}
