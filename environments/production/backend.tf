terraform {
  backend "s3" {
    bucket = "tfstate-811187"
    key    = "infra-core/production/terraform.tfstate"

    region = "eu-west-2"

    endpoints = {
      s3 = "https://lon1.digitaloceanspaces.com"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
