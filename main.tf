# To create one security group
resource "aws_security_group" "jenkins_sec_group" {
  name        = "web_app"
  description = "security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = local.sec_group_tag
  }
}

// Generate Private Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = local.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save Private Key file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = local.key_name

  provisioner "local-exec" {
    command = "chmod 400 ${local.key_name}"
  }
}

# Create a EC2 instance
resource "aws_instance" "jenkins_ec2" {
  ami           = local.ami 
  instance_type = local.instance_type  
  key_name      = aws_key_pair.key_pair.key_name
  security_groups= ["web_app"]

  tags = {
    Name = local.ec2_tag,
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.jenkins_ec2.public_ip},' --user ubuntu --private-key ${local.key_name} jenkins.yaml"
  }
}