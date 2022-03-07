

//==============================================================================================//
//     -In this example we will see how lifecycle works. We will how we can prevent "destroy"   //
//==============================================================================================//

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
  ami           = "ami-048ff3da02834afdc"
  instance_type =  "t2.micro"

  tags = {
    Name = "Server"
  }
  lifecycle {
      # will prevent "terraform destroy" if set to "true"
      prevent_destroy = true  
  }
}


//Get the output variable after deployment. Example public IP of instance.
output "instance_ip_addr" {
  value  = aws_instance.my_server.public_ip
}