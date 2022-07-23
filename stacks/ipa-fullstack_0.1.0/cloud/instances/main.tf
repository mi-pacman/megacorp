terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.26.0"
    }
  }
  required_version = ">= 0.14.5"
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "sg_22" {
  name   = "sg_22"
  vpc_id = aws_vpc.vpc.id

  # TCP SSH access from the VPC
  ingress {
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
}

resource "aws_security_group" "sg_80" {
  name   = "sg_80"
  vpc_id = aws_vpc.vpc.id

  # TCP HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "sg_88" {
  name   = "sg_88"
  vpc_id = aws_vpc.vpc.id

  # TCP & UDP Kerberos access from the VPC
  ingress {
    from_port   = 88
    to_port     = 88
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 88
    to_port     = 88
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_123" {
  name   = "sg_123"
  vpc_id = aws_vpc.vpc.id

  # UDP NTP access from the VPC
  ingress {
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_389" {
  name   = "sg_389"
  vpc_id = aws_vpc.vpc.id

  # TCP LDAP access from the VPC
  ingress {
    from_port   = 389
    to_port     = 389
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

resource "aws_security_group" "sg_443" {
  name   = "sg_443"
  vpc_id = aws_vpc.vpc.id

  # TCP HTTPS access from the VPC
  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_security_group" "sg_464" {
  name   = "sg_464"
  vpc_id = aws_vpc.vpc.id

  # TCP Kerberos access from the VPC
  ingress {
    from_port   = 464
    to_port     = 464
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

resource "aws_security_group" "sg_636" {
  name   = "sg_636"
  vpc_id = aws_vpc.vpc.id

  # TCP & UDP LDAPS Kerberos access from the VPC
  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                         = "<AMI>"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.subnet_public.id
  vpc_security_group_ids      = [aws_security_group.sg_22.id, aws_security_group.sg_80.id, aws_security_group.sg_88.id, aws_security_group.sg_123.id, aws_security_group.sg_389.id, aws_security_group.sg_443.id, aws_security_group.sg_464.id, aws_security_group.sg_636.id]
  associate_public_ip_address = true

  tags = {
    Name = "ipa-controller"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
