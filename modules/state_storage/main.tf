resource "digitalocean_spaces_bucket" "terraform_state" {
  name          = "tfstate-${random_integer.suffix.result}"
  region        = var.region
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "terraform-state-lifecycle-${random_integer.suffix.result}"
    prefix  = ""
    enabled = true

    abort_incomplete_multipart_upload_days = 3

    noncurrent_version_expiration {
      days = 90
    }
  }
}
