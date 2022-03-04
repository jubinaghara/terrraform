# Terrraform
HashiCorp Terraform

## About
Learning terraform...😎

### Commands
#### Basic commands
terraform init 
terraform fmt     (formatting the code structure - spacing and indentation)
terraform validate
terraform plan    (this command also does the validation, so no need to run validate cmd separetely)
terraform apply   (to execute the deployment)
terraform refresh (match the state file with whatever the remote instance is)
terraform output  (if you have added the output variable to the file)
terraform output -json
terraform output -raw <name of the parameter> 
terraform apply -auto-approve (no need to type "yes")
terraform destroy (destroy all resources)
terraform apply -destroy (destory all resoruces)
terraform apply -replace=aws_instance.my_server (replace specfic resource)
terraform providers (get list of all providers you are currently using)
#### Variables
terraform plan -var=<variable name>="<value>"
terraform plan (another option to use variable in your code is to reate a file name with extension ".tfvars" and add all variables to this file)
#### Cloud Workspace
terraform workspace list (by default all are in *defult workspace)

#### Example: Programmatically access aws cli
First create rsa key: sudo ssh-keygen -t rsa   
Give following path: /root/.ssh/terraform
Elevate the permission: chmod 400 /root/.ssh/terraform.pub
terraform apply 
sudo ssh ec2-user@$(terraform output -raw public_ip) -i /root/.ssh/terraform

### Variables and Ouputs

- terraform.tfvars
- additional variable files and -var-file
- additional autoloaded files
- var
- TF_VAR_
- Ouput CLI
- Chaining outputs from a module
- Local values
- Data sources

Priority of variables:
1) Command -var="variable name" > 2) vars.auto.tfvars > 3) terraform.tfvars