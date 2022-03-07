

//==================================================================================//
//     -In this example we will see how depends_on works                            //
//     -Idea is to create the S3 bucket after instance is created                   //
//==================================================================================//

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

variable "instance_type" {
  type = string
  description = "size of instance"
}


resource "aws_instance" "my_server" {
  ami           = "ami-048ff3da02834afdc"
  instance_type =  "t2.micro"

  tags = {
    Name = "example instance"
  }
}

resource "aws_s3_bucket" "bucket" {
# depends_on example. Creates S3 bucket after instance is create.
  bucket = "my-tf-test-bucket-07032022"
  depends_on = [
      aws_instance.my_server
  ]
}

//Get the output variable after deployment. Example public IP of instance.
output "instance_ip_addr" {
  value  = aws_instance.my_server.public_ip
}