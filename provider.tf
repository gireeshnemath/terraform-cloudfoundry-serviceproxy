provider "cloudfoundry" {
  api_url  = var.cf_api
  user     = var.cf_username
  password = var.cf_password

}
provider "hsdp" {
  region = "us-east-1"
}

provider "random" {
}