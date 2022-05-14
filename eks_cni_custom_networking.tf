locals {
  enable_eks_outputs = true # disable to hide eks outputs on terraform runs

  # Step 1. Ensure eks subnets are enabled by checking output variable "eks_cni_custom_networking_subnets_enabled" is true. If this is not enabled for your project (it's disabled by default) please create a ticket https://cyber.nasdaq.com/requests/servicedesk/customer/portal/2/create/163
  # Step 2. Ensure you can execute kubectl commands towards the cluster.
  # Step 3. Grab the eniconfigs from the latest terraform apply output. Add this config to the eks_cni_custom_networking.yaml file found in this directory.
  # Step 4. Apply the eks_cni_custom_networking.yaml with kubectl apply -f eks_cni_custom_networking.yaml.
  # Step 5. Verify with kubectl (get pods -o wide -w -n custom-cni) or your favourite kubernetes tool that custom cni pods are launched and successfully completed.
  # Step 5. Terminate eks nodes in the aws ec2 console to apply cni custom networking config on the nodes. (The termination/recreation by asg will apply the config)
  # Step 6. Verify with kubectl (get pods -o wide -w -n custom-cni) or your favourite kubernetes tool that pods are now being launched with 100.100.x.x ip addresses.
  # Step 7. Modify the execution time of the cronjob to what suits your project. The cronjob is idempotent but you can reduce the cadence if you so wish. Cronjob is to ensure that the configuration stays intact.

  # If you want to apply the config for additional clusters, change the module instantiation reference below prior to executing the above steps.

  eks_sg_node_id       = try(module.eks.eks_sg_node_id, null)
  eniconfig_output     = try([for k, v in local.eks_subnets_eni_config : "\napiVersion: crd.k8s.amazonaws.com/v1alpha1\nkind: ENIConfig\nmetadata:\n  name: ${k}\nspec:\n  subnet: ${v}\n  securityGroups:\n    - ${local.eks_sg_node_id}\n    #- insert potential additional security groups here, to suit your needs for outbound access\n---"], null)
}

output "eks_cni_custom_networking_subnets_enabled" {
  description = "Bool showing whether custom cni eks subnets are enabled"
  value       = local.enable_eks_outputs ? (length(local.subnet_eks_azs) > 0 ? true : false) : null
}

output "eniconfig0" {
  description = "eniconfig for eks cni custom networking"
  value       = local.enable_eks_outputs ? try(local.eniconfig_output[0], null) : null
}
output "eniconfig1" {
  description = "eniconfig for eks cni custom networking"
  value       = local.enable_eks_outputs ? try(local.eniconfig_output[1], null) : null
}
output "eniconfig2" {
  description = "eniconfig for eks cni custom networking"
  value       = local.enable_eks_outputs ? try(local.eniconfig_output[2], null) : null
}
output "eniconfig3" {
  description = "eniconfig for eks cni custom networking"
  value       = local.enable_eks_outputs ? try(local.eniconfig_output[3], null) : null
}