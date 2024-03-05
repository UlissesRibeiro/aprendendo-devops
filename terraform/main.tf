terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  }

resource "aws_key_pair" "deployer" {
  key_name   = "aws_keys.pub"
  public_key = file("/root/.ssh/aws_keys.pub")
}

terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "descomplicando-terraform-ulisses"
    key    = "terraform-test.tfstate"
    region = "us-east-1"
  }
}