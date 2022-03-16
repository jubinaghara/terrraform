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

# Input variable example
variable "instance_type" {
  type = string
  description = "size of instance"
  sensitive = false //this doesn't mean it hidden. You can clearly see in terraform state file
  validation {
      condition = can(regex("^t2.", var.instance_type))  //Only allow instance id starting with "t2."
      error_message = "Please enter a valid instance_id."
  }
}


locals {
  project_name = "terraform-test"
}

resource "aws_instance" "my_server" {
  ami           = "ami-048ff3da02834afdc"
  instance_type =  var.instance_type


  tags = {
    Name = "ExampleTerraformIaC-${local.project_name}"
  }
}


//Get the output variable after deployment. Example public IP of instance.
output "instance_ip_addr" {
  value  = aws_instance.my_server.public_ip
}