variable "billing_account_id" {
  description = "Google Cloud Billing Account ID"
  type        = string
  sensitive   = true
}

variable "gcp_region" {
  description = "The Google Cloud region"
  type        = string
}

variable "env" {
  description = "The environment name (e.g., sandbox, dev, test, stage, prod)"
  type        = string
}
