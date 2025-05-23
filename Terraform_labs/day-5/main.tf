#definition of provider
provider "aws" {
    region = "ap-south-1"
}

#creating vpc
resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

# creation of subnet
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.cidr_block
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = var.map_public_ip_on_launch
}

# Internet gateway creation
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.myvpc.id
}

#Route table creation and defining the route of internet gateway 
resource "aws_route_table" "rt" {          
    vpc_id = aws_vpc.myvpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }
  
}

# route table assignement to subnet
resource "aws_route_table_association" "a" {   
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rt.id
}


##Aws instance cretion and attaching vpc to it

resource "aws_key_pair" "example" {
    key_name = "deployer"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxp9rxPX00ZBbh+oUIidty+HtiWUdVncLDbiGFVlwuQ MZ-AKANAWADE@MZ-AKANAWADE"
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.example.key_name
    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.webSg.id]
    
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACCsafa8T19NGQW4fqFCInbcvh7YllHVZ3Cw24hhVZcLkAAAAKA8jZ/HPI2f\nxwAAAAtzc2gtZWQyNTUxOQAAACCsafa8T19NGQW4fqFCInbcvh7YllHVZ3Cw24hhVZcLkA\nAAAEDRf082jxwGo5H0cKuEuQ17PmNFEWWQeUQzdnCYU60EIKxp9rxPX00ZBbh+oUIidty+\nHtiWUdVncLDbiGFVlwuQAAAAGU1aLUFLQU5BV0FERUBNWi1BS0FOQVdBREUBAgME\n-----END OPENSSH PRIVATE KEY-----"
      host = self.public_ip
    }

    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
    }

    provisioner "remote-exec" {
        inline = [ 
        "echo Hello from the remote instance",
        "sudo apt update -y",  # Update package lists (for ubuntu)
        "sudo apt-get install -y python3-pip",  # Example package installation
        "cd /home/ubuntu",
        "sudo apt install flask",
        "sudo python3 app.py &"
         ]
    }

}

