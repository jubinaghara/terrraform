
//==================================================================================//
//     -This terraform code creates EC2 instance with AWS linux                     //
//     -It will also create security group with two rules to allow HTTP, SSH        //
//     -Aso, after resources are created it will run cloud-init script (user-data)  //
//     -We will grab public_ip as output to SSH into EC2 instance                   //
//      [USES REMOTE CLOUD BACKEND - MAKE SURE YOU HAVE CREATED ACCOUNT AND ORG]    //                                                 //
//==================================================================================//

terraform {
  backend "remote"  {
    organization = "agharajubin" //replace with your ogranization name that created in terraform

    workspaces {
      name = "providers"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}

# Referencing the data source so we can use at multiple places.
data "aws_vpc" "main" {
  id = "vpc-a8d64ad2"
}

provider "aws" {
  region = "us-east-1"
}

//=================================================================================//
//              Creats Security Group and two rules to allow SSH and HTTP          //
//=================================================================================//
resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My server security group"
  vpc_id      =  data.aws_vpc.main.id

  ingress = [{
    description      = "HTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
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

//=================================================================================//
//              Creats EC2 instance with instance type t2.micro                    //
//=================================================================================//

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdClkiIx5LOHv9rtCgFpZw0PLeyEoJolBgd/rkPlA3YsTZ77YKNcVyfzSzT4YmgFmj1Icbi4H7RGu2CkVOBy4NkU2p5kuxAPzz31sOGD/aruhTHOqi+lyzjXsyz7Ehna3fzAqTicjCnlROAtT0PTWoRWrN19AkcU10f0I8PWHpBPK4vaIf3AxrV+AmhVr7iw1Gb5mT+eQFfXIM6xgoW7rkQRPnnPSwOANnuWSEApR6hPYyXgi1XCLu/j6k9694Oh17o6v0iWu2BHF8XP1m/lEpwvgbXO22fU2NOprmNSdKy/nJA/Ypdd3roE0zjDQae0OWNTmwmZOq75VXbP7tUKHCqV3PlZbUdUvGp/Zxnb1MhX0dqAaUKeSyEFbBHZ7G5SJzHKOYgebr00EKM9+5G6PJimlgDOoah2JaI0QGOHpYVlnXHxkqqbG9xdKzVGONSREU1MqOv3dAcb6wuWSYabbAHziucBmkHzBv0GVv0P08mjdzciJfy1jkGQzbeR21oIk= root@LAPTOP-BH2RCELB"
}

data "template_file" "user-data" {
    template = file("./userdata.yaml")
}

resource "aws_instance" "my_server" {
  ami           = "ami-048ff3da02834afdc"
  instance_type =  "t2.micro"
  key_name =  "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data = data.template_file.user-data.rendered
  tags = {
    Name = "ExampleTerraform"
  }
}


//=================================================================================//
//              Grab public_ip from output to SSH into our EC2 instance            //
//=================================================================================//
output "public_ip" {
  value = aws_instance.my_server.public_ip
}