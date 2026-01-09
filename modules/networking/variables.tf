variable "platform_cidr" {
  description = "Immutable platform CIDR block (e.g., 10.64.0.0/12)."
  type        = string
}

variable "region" {
  description = "DigitalOcean region for all VPCs (explicit and fixed for this platform)."
  type        = string
}

variable "projects" {
  description = <<EOT
Explicit map of project slug -> project index (0..15 for a /12 split into /16s).
Never renumber an existing project. Never reuse an index.
EOT
  type        = map(number)

  validation {
    condition     = alltrue([for _, idx in var.projects : idx >= 0 && idx <= 15])
    error_message = "Each project index must be between 0 and 15 inclusive (platform /12 -> project /16 uses 4 bits)."
  }
}

variable "name_prefix" {
  description = "Optional prefix for VPC names, e.g. 'platform'. Leave empty if you want names to start with the project slug."
  type        = string
  default     = ""
}

variable "envs" {
  description = "Explicit environment index mapping. Keep this immutable as a contract."
  type        = map(number)
  default = {
    dev   = 0
    stage = 1
    prod  = 2
  }

  validation {
    condition     = length(var.envs) == 3 && alltrue([for k, v in var.envs : contains(["dev", "stage", "prod"], k) && v >= 0 && v <= 15])
    error_message = "envs must contain dev, stage, prod with indices 0..15."
  }
}

variable "enabled_envs" {
  description = "Environments to actually provision VPCs for. CIDRs remain reserved for all envs."
  type        = set(string)
  default     = ["prod"]

  validation {
    condition     = alltrue([for e in var.enabled_envs : contains(["dev", "stage", "prod"], e)])
    error_message = "enabled_envs must be a subset of: dev, stage, prod."
  }
}

variable "project_enabled_envs" {
  description = <<EOT
Map of project slug -> set of environments to provision VPCs for.
CIDRs remain reserved for all envs (dev/stage/prod) regardless.

Example:
{
  "infra-core" = ["prod"]
  "infra-cicd" = ["dev", "stage", "prod"]
}
EOT

  type    = map(set(string))
  default = {}

  validation {
    condition = alltrue(flatten([
      for _, envs in var.project_enabled_envs : [
        for e in envs : contains(["dev", "stage", "prod"], e)
      ]
    ]))
    error_message = "project_enabled_envs values must be subsets of: dev, stage, prod."
  }
}
