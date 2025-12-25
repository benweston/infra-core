variable "do_token" {
  type        = string
  sensitive   = true
  description = "DigitalOcean API token"
}

variable "env" {
  description = "The environment name (e.g., Development, Staging, Production)"
  type        = string

  validation {
    condition     = contains(["Development", "Staging", "Production"], var.env)
    error_message = "The env variable must be one of 'Development', 'Staging', 'Production'."
  }
}

variable "region" {
  description = "The DigitalOcean region"
  type        = string
}
