locals {
  role_name              = "service/service.terraform"
  environment            = data.terraform_remote_state.network.outputs.environment
  region                 = data.terraform_remote_state.network.outputs.region
  application_short_name = data.terraform_remote_state.network.outputs.application_short_name
  business_unit          = data.terraform_remote_state.network.outputs.business_unit
  account_id             = data.terraform_remote_state.network.outputs.account_id
  application            = data.terraform_remote_state.network.outputs.application
  project_name           = data.terraform_remote_state.network.outputs.project_name
  project_code           = data.terraform_remote_state.network.outputs.project_code
  requestor              = data.terraform_remote_state.network.outputs.requestor
  application_id         = data.terraform_remote_state.network.outputs.application_id
  request_id             = data.terraform_remote_state.network.outputs.request_id
  service_owner_support  = data.terraform_remote_state.network.outputs.service_owner_support
  vpc_id                 = data.terraform_remote_state.network.outputs.vpc_id
  vgw_id                 = data.terraform_remote_state.network.outputs.vgw_id

  default_parameters = {
    account_id             = local.account_id
    application            = local.application
    application_short_name = local.application_short_name
    business_unit          = local.business_unit
    environment            = local.environment
    region                 = local.region
    vpc_id                 = local.vpc_id
  }

  tags = {
    "terraform"             = "true"
    "Project Name"          = local.project_name
    "Project Code"          = local.project_code
    "Business Unit"         = upper(local.business_unit)
    "Environment"           = local.environment
    "Service Owner Support" = local.service_owner_support
    "Requestor"             = local.requestor
    "Application Id"        = local.application_id
    "Request Id"            = local.request_id
  }

  subnet_public_a  = data.terraform_remote_state.network.outputs.subnet_public_a_id
  subnet_public_b  = data.terraform_remote_state.network.outputs.subnet_public_b_id
  subnet_public_c  = data.terraform_remote_state.network.outputs.subnet_public_c_id
  subnet_public_d  = data.terraform_remote_state.network.outputs.subnet_public_d_id
  subnet_private_a = data.terraform_remote_state.network.outputs.subnet_private_a_id
  subnet_private_b = data.terraform_remote_state.network.outputs.subnet_private_b_id
  subnet_private_c = data.terraform_remote_state.network.outputs.subnet_private_c_id
  subnet_private_d = data.terraform_remote_state.network.outputs.subnet_private_d_id
  
  subnet_private_ids     = data.terraform_remote_state.network.outputs.subnet_private_ids
  subnet_eks_azs         = try(data.terraform_remote_state.network.outputs.subnet_eks_azs, [])
  subnet_eks_ids         = try(data.terraform_remote_state.network.outputs.subnet_eks_ids, [])
  eks_subnets_eni_config = length(local.subnet_eks_azs) > 0 ? zipmap(local.subnet_eks_azs, local.subnet_eks_ids) : null
}
