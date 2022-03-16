
//=================================================================================//
//   Get the output variable after deployment. Example public IP of instance.      //
//=================================================================================//
output "instance_ip_addr" {
  value  = aws_instance.my_server.public_ip
}