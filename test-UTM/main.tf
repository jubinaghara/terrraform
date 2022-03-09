terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Referencing the data source so that we can use at multiple places.
data "aws_vpc" "main" {
  id = "vpc-a8d64ad2"
}


resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My server security group"
  vpc_id      =  data.aws_vpc.main.id

  ingress = [{
    description      = "HTTPS"
    from_port        = 4444
    to_port          = 4444
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids =  []
    security_groups =  []
    self = false
  },
  {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids =  []
    security_groups =  []
    self = false
  }]
  egress {
    description = "output traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = []
    security_groups = []
    self = false
  }

  tags = {
    Name = "access_to_my_server"
  }
}


resource "aws_instance" "my_server" {
  ami           = "ami-0754df07d8f22d2a1" //Hourly: Sophos UTM US-EAST-1 AMI ID
  instance_type =  "t2.medium"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  tags = {
    Name = "Sophos UTM"
  }
}


//Get the output variable after deployment. Example public IP of instance.
output "instance_ip_addr" {
  value  = aws_instance.my_server.public_ip
}