

//======================================================================================//
//     -In this example we will see how counts works                                    //
//     -Idea is to specify "foreach" meta argument to launch specific type of instances //
//======================================================================================//

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

resource "aws_instance" "my_server" {
  for_each = {
      nano = "t2.nano"
      micro = "t2.micro"
      small = "t2.small"
  }
  ami           = "ami-048ff3da02834afdc"
  instance_type =  each.value

  tags = {
    Name = "Server - ${each.key}"
  }
}


//Get the output variable after deployment. Example public IP of instance.
output "instance_ip_addr" {
  value  = values(aws_instance.my_server)[*].public_ip
}