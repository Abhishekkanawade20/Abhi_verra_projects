
provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.cidr_block
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.myvpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }
  
}

resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rt.id
}





