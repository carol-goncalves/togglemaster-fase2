terraform {
  backend "s3" {
    bucket       = "togglemaster-tfstate-698126163746"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
