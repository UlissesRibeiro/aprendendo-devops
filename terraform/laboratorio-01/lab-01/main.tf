terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  version = "~> 5.0"
  region  = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa.pub"
  public_key = file("/root/.ssh/id_rsa.pub")
}

terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "terraform-lab-01"
    key    = "terraform-test.tfstate"
    region = "us-east-1"
  }
}