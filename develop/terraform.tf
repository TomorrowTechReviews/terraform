terraform {
  required_version = ">= 1.1.0"

  cloud {
    organization = "tomorrow-tech-reviews"

    workspaces {
      name = "develop"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
