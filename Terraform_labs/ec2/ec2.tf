# This is test file 

provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "dev_instance" {
  ami = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
}

# adding new line 
#added new line
