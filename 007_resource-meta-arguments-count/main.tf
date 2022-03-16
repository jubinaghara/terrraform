

//======================================================================================//
//     -In this example we will see how counts works                                    //
//     -Idea is to specify "count" meta argument to launch specific number of instances //
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
  count = 2  #number of instance to be provisioned
  ami           = "ami-048ff3da02834afdc"
  instance_type =  "t2.micro"

  tags = {
    Name = "Server - ${count.index}"
  }
}


//Get the output variable after deployment. Example public IP of instance.
output "instance_ip_addr" {
  value  = aws_instance.my_server[0].public_ip
  //value  = aws_instance.my_server[*].public_ip  //get all public IPs
}