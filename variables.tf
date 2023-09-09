locals {
 ami           = "ami-0af6e9042ea5a4e3e"
 instance_type = "t2.micro"
 name_tag      = "My EC2 Instance"
 key_name      = "NginxApp"
 ec2_tag       = "My EC2 Instance"
 sec_group_tag = "Web App"
}

output "public_ip" {
  value       = aws_instance.nginx_ec2.public_ip
  description = "Public IP Address of EC2 instance"
}