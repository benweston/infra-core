variable "do_token" {
  type        = string
  sensitive   = true
  description = "DigitalOcean API token"
}

variable "env" {
  description = "The environment name (e.g., Development, Staging, Production)"
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.env)
    error_message = "The env variable must be one of 'development', 'staging', 'production'."
  }
}

variable "region" {
  description = "The DigitalOcean region"
  type        = string
}

variable "spaces_access_key_id" {
  type      = string
  sensitive = true
}

variable "spaces_secret_access_key" {
  type      = string
  sensitive = true
}
