# This module is related to terraform remote backend

provider "aws" {
    region = var.region  
}

resource "aws_instance" "abhishek" {
    ami = var.ami
    instance_type = var.instance_type
    
}

resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucket
}