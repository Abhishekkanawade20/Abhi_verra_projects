# This is an o/p file using this we can print the values like instance public ipaddress

output "public-ip-address" {
    value = aws_instance.dev_instance.public_ip
}

output "ami-id" {
    value = aws_instance.dev_instance.ami
}

output "subnet-id" {
    value = aws_instance.dev_instance.subnet_id  
}