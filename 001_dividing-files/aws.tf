
//=================================================================================//
//   Creats EC2 instance with instance_type specified in "terraform.tfvar" file.   //
//=================================================================================//
resource "aws_instance" "my_server" {
  ami           = "ami-048ff3da02834afdc"
  instance_type =  var.instance_type

  tags = {
    Name = "ExampleTerraformIaC-${local.project_name}" //refers to a local variable defined in "main.tf"
  }
}

