//==================================================================================//
//     -This terraform code creates security group using dynamic block              //
//     -Dynamic block eliminates the repetation of code and ease the config         //
//==================================================================================//


terraform {
   required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}


provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


data "aws_vpc" "main" {
  id = "vpc-a8d64ad2"
}

locals {
  ingress = [{
    port  = 443
    description = "Port443"
    protocol = "tcp"
  },
   {
    port  = 80
    description = "Port80"
    protocol = "tcp"
  },
  
  ]
}

resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My server security group"
  vpc_id      =  data.aws_vpc.main.id

  #Using dynamic block we can create multiple security group rules without repetation of code
  #Below code will create two security rule one for port 80 and other for 443
  dynamic ingress {
    for_each = local.ingress
    content {
        description      = ingress.value.description
        from_port        = ingress.value.port
        to_port          = ingress.value.port
        protocol         = ingress.value.protocol
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
  }
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
