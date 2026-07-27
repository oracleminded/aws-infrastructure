terraform {
  backend "s3" {
    bucket       = "mypawsbnb-terraform-state-061446588118-us-east-2"
    key          = "aws-infrastructure/environments/development/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}