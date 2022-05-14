# This is set automatically during account provisioning in your Terraform
# Enterprise workspace. It is possible but not recommended to override this
# variable in an auto.tfvars file.
variable "upstream_workspace" {
  description = "TFE workspace name which contains info from provisioning."
  default     = "workspace-does-not-exist"
}
