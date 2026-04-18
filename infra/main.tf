provider "aws" {
  region = "ap-south-1"
}

# -----------------------------
# VARIABLES
# -----------------------------
variable "instance_name" {
  default = "react-app-server"
}

variable "my_ip" {
  description = "Your public IP for SSH access"
  default     = "0.0.0.0/0" # CHANGE to YOUR_IP/32
}

# Docker image (UPDATE if needed)
variable "docker_image" {
  default = "ghostatdocker/react-app-dev:latest"
}

# -----------------------------
# KEY PAIR
# -----------------------------
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.generated.private_key_pem
  filename        = "${path.module}/react-app-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "deployer" {
  key_name   = "react-app-key"
  public_key = tls_private_key.generated.public_key_openssh
}

# -----------------------------
# SECURITY GROUP
# -----------------------------
resource "aws_security_group" "react_sg" {
  name        = "react-app-sg"
  description = "Allow HTTP and SSH"

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# UBUNTU 22.04 AMI
# -----------------------------
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# -----------------------------
# EC2 INSTANCE WITH USER DATA
# -----------------------------
resource "aws_instance" "react_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.react_sg.id]

  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOF
				#!/bin/bash
				sudo apt update
				sudo apt install docker.io git -y
				sudo systemctl start docker
				sudo systemctl enable docker
				sudo usermod -aG docker ubuntu
				git clone https://github.com/Francis-M-D/DevOps_Project_3_Reactjs_E-commerce_Application.git
				cd DevOps_Project_3_Reactjs_E-commerce_Application
				chmod +x *.sh
				./build.sh
				./deploy.sh
				sudo apt install openjdk-17-jdk -y
				wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
				sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
				sudo apt update
				sudo apt install jenkins -y
				sudo systemctl start jenkins
				EOF
}

# -----------------------------
# OUTPUTS
# -----------------------------
output "public_ip" {
  value = aws_instance.react_server.public_ip
}

output "app_url" {
  value = "http://${aws_instance.react_server.public_ip}"
}

output "ssh_command" {
  value = "ssh -i react-app-key.pem ubuntu@${aws_instance.react_server.public_ip}"
}
