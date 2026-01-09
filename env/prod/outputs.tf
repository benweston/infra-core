output "spaces_object_storage_bucket_name" {
  description = "The name of the Terraform remote state bucket."
  value       = module.state_storage.spaces_object_storage_bucket_name
}

output "vpc_ids" {
  description = "Map of 'project/env' -> DigitalOcean VPC ID."
  value       = module.networking.vpc_ids
}

output "env_cidrs" {
  description = "Map of project -> env -> CIDR."
  value       = module.networking.env_cidrs
}

output "network_plan" {
  description = "Human-readable network plan (no secrets)."
  value       = module.networking.network_plan
}

output "vpcs" {
  description = "Provisioned VPCs keyed by 'project/env' with IDs, names, region, and CIDR."
  value       = module.networking.vpcs
}
