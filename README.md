# Terrraform
HashiCorp Terraform

## About
Learning Terraform...😎

## How to pass the hashicorp certified: terraform associate
1. https://youtu.be/V4waklkBC38 (Complete freeCodeCamp 13 hrs tutorial)
2. Follow along. Get you hands dirty
3. 

### Initial setup
1.	If you are using Windows, install Linux sub-system on windows (wsl) (command > wsl --install Ubuntu)
2.	Open WSL terminal in vscode
3.	Install terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
4.	Install terraform vscode extension
5.	Install aws CLI https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
6.	Create new AWS user with programmatic access user 
8.  Configure AWS CLI (command > aws configure -> enter access-ID, secret and default region)

### Commands
#### Basic commands
- terraform init 
- terraform fmt     (formatting the code structure - spacing and indentation)
- terraform validate
- terraform plan    (this command also does the validation, so no need to run validate cmd separetely)
- terraform apply   (to execute the deployment)
- terraform refresh (match the state file with whatever the remote instance is)
- terraform output  (if you have added the output variable to the file)
- terraform output -json
- terraform output -raw 'name of the parameter' 
- terraform apply -auto-approve (no need to type "yes")
- terraform destroy (destroy all resources)
- terraform apply -destroy (destory all resoruces)
- terraform apply -replace=aws_instance.my_server (replace specfic resource)
- terraform providers (get list of all providers you are currently using)
- terraform console

#### Terrform state commands
- terrafom state list (list resoruce in the state)
- terraform state mv (move an item in the state)
    - example if you want to change the instance name  - terraform state mv aws_instance.old_name aws_instance.new_name
- terraform state pull (pull current remote state and output to stdout)
- terraform state push (update remote state from a local state)
- terraform state replace-provider (replace provider in the state)
- terraform state rm (remove instances from the state)
- terraform state show 'resource name' (show a resource in the state)

#### Saved plan
terraform plan -out=my_saved_plan.plan (to save the plan)
terraform apply my_saved_plan.plan (to apply the saved plan)

#### Troubleshooting
TF_LOG=TRACE terraform apply (enable trace level)
TF_LOG=TRACE TF_LOG_PATH=./terraform.log terraform apply (enable trace level, save log file)





#### Variables
- terraform plan -var="variable name"="value"
- terraform plan (another option to use variable in your code is to reate a file name with extension ".tfvars" and add all variables to this file)

#### Priority of variables:
1) Command -var="variable name" 2) vars.auto.tfvars 3) terraform.tfvars

💡 You can use "jq" to parse json -- i.e. reading specific element of an output json object.
#### Variables and Ouputs

- terraform.tfvars
- additional variable files and -var-file
- additional autoloaded files
- var
- TF_VAR_
- Ouput CLI
- Chaining outputs from a module
- Local values
- Data sources 

Data source: One of the example of data source is - you can filter the image by enviroment and version instead of specifying the ami-id.

#### Cloud Workspace
terraform workspace list (by default all are in *defult workspace)

#### Example: Programmatically access aws cli
- First create rsa key: sudo ssh-keygen -t rsa   
- Give following path: /root/.ssh/terraform
- Elevate the permission: chmod 400 /root/.ssh/terraform.pub
- terraform apply 
- sudo ssh ec2-user@$(terraform output -raw public_ip) -i /root/.ssh/terraform


