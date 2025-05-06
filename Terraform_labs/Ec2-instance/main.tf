# This is test file 

provider "aws" {
  region = var.region
}


resource "aws_instance" "dev_instance" {
  ami = var.ami
  instance_type = var.aws_instance
  subnet_id = var.subnet_id
}

