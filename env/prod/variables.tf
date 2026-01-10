variable "do_token" {
  type        = string
  sensitive   = true
  description = "DigitalOcean API token"
}

variable "env" {
  description = "The environment name (e.g., Development, Staging, Production)"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "The env variable must be one of 'dev', 'stage', 'prod'."
  }
}

variable "region" {
  description = "The DigitalOcean region"
  type        = string
}
