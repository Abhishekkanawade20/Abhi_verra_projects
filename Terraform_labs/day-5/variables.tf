
variable "cidr" {
  description = " value of cidr"
  type = string
}

variable "cidr_block" {
    description = "value of cidr_block"
    type = string
}

variable "map_public_ip_on_launch" {
 description = "True or false"  
 type = string
}

variable "ami" {
  description = "value of ami"
}

variable "instance_type" {
  description = "value of instance type"
  
}