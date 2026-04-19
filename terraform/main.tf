provider "aws" {
  region = "ap-south-1"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployer" {
  key_name   = "devops-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "pem" {
  content  = tls_private_key.key.private_key_pem
  filename = "devops-key.pem"
}

resource "aws_security_group" "sg" {
  name = "react-app-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  security_groups = [aws_security_group.sg.name]

user_data = <<-EOF
	#!/bin/bash
	
	# Update system
	apt update -y
	
	# Install Docker
	apt install docker.io -y
	systemctl start docker
	systemctl enable docker
	
	# Allow ubuntu user to run docker
	usermod -aG docker ubuntu
	
	# Install Git (optional)
	apt install git -y
	
	# Create app directory
	mkdir -p /home/ubuntu/app
	chown -R ubuntu:ubuntu /home/ubuntu/app
	
	EOF

  tags = {
    Name = "React-App"
  }
}
