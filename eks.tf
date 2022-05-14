module "eks" {
  source             = "tfe.ops.nadq2universalservices.gi.nadq.ci/nasdaq/compute-eks/aws"
  version            = "~> 2.2.0"
  tags               = local.tags
  default_parameters = local.default_parameters

  # EKS Cluster Parameters
  eks_cluster_details = {
    cluster_identifier = "module-eks"
    cluster_version    = "1.18"
    cluster_subnets    = join(",", local.subnet_private_ids)
  }

  # EKS Node Group Parameters
  eks_node_group_details = {
    instance_type = "t3.medium"
    min_size      = "0"
    max_size      = 1 * length(local.subnet_private_ids)
    tier          = "private"
  }

  # additional_security_groups = [
  #   "local.prereq_security_groups"
  # ]
  #
  ## Add Teleport
  ## Do not enable this until *after* the EKS cluster is created.
  # k8s_teleport_details = {
  #   teleport                    = true
  #   create_teleport_certificate = true
  #   nginx_ingress               = true
  # }
  ## ######################################
  ## STOP!! Do not just remove this module!
  ## You have to follow certain steps!
  ## ######################################
  # Step 1 of removing EKS
  //  k8s_teleport_details = {
  //     teleport      = false
  //     nginx_ingress = false
  //  }
  # Step 2 of removing EKS
  //     k8s_configuration_details = {
  //        k8s_configurations = false
  //     }
  # Step 3 of removing EKS
  # comment out this module
  # comment out all code in "eks_eni_custom_networking.tf"
  # comment out all resources in "kubernetes_user_for_gitlab.tf"
  providers = {
    aws.local             = aws.local
    aws.perimeter         = aws.perimeter
    aws.universalservices = aws.universalservices
  }
}
