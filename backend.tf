terraform {
  backend "s3" {
    bucket = "tfstate-946483"
    key    = "infra-core/terraform.tfstate"

    region = "lon1"

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
