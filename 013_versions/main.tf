


terraform {
   required_version = ">= 3.0.0" #progressive versioning

    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.3.0" #progressive versioning 'tild and arrow ~>"  will pull the latest patch version
    }
  }
}
