terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

# Importer ta clé SSH dans AWS
resource "aws_key_pair" "zainab_key" {
  key_name   = "zainab-key"
  public_key = file("~/.ssh/zainab-key.pub")
}

# Groupe de sécurité (firewall)
resource "aws_security_group" "portfolio_sg" {
  name        = "portfolio-sg"
  description = "Allow HTTP, HTTPS, SSH, Jenkins"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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
}

# Instance EC2 (Free Tier)
resource "aws_instance" "portfolio" {
  ami                    = "ami-0c6ebbd55ab05f070"   # Ubuntu 22.04 Paris
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.zainab_key.key_name
  vpc_security_group_ids = [aws_security_group.portfolio_sg.id]

  tags = {
    Name = "zainab-portfolio"
  }
}

# Afficher l'IP publique après création
output "public_ip" {
  value = aws_instance.portfolio.public_ip
}
