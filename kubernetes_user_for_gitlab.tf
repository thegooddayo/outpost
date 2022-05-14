locals {
  enable_kubernetes_user_for_gitlab = true
}

## If you want to push credentials and eks references to a gitlab project which can deploy
## your containers to kubernetes, uncomment all lines in this file and pass in values for the
## variables to terraform through *.auto.tfvars or gitlab ci/cd variables

############
# VARIABLES
############
variable "GITLAB_TOKEN" {
  description = "API access to gitlab for the GITLAB_PROJECT_ID"
  type        = string
  default     = ""
}

variable "GITLAB_PROJECT_IDS" {
  description = "Gitlab Project IDs which will receive the credentials"
  type        = list(string)
  default     = [""]
}

variable "GITLAB_ENV_SCOPES" {
  description = "The scope to apply to GITLAB environment variables, e.g. dev, pro etc. Length must match GITLAB_PROJECT_IDS"
  type        = list(string)
  default     = [""]
}

//############
//# RESOURCES
//############
//
//resource "aws_iam_user" "eks_gitlab_user" {
//  provider = aws.local
//  count    = local.enable_kubernetes_user_for_gitlab ? 1 : 0
//
//  name = module.eks.eks_cluster_name
//  path = "/service/"
//  tags = local.tags
//}
//
//resource "aws_iam_policy" "eks_gitlab_user_policy" {
//  provider = aws.local
//  count    = local.enable_kubernetes_user_for_gitlab ? 1 : 0
//
//  name        = "eks_read_only_policy_${aws_iam_user.eks_gitlab_user[0].name}"
//  path        = "/"
//  description = "For kubectl users to be able to auth with eks"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Sid": "EKSRead",
//      "Action": [
//        "eks:Describe*",
//        "eks:List*"
//      ],
//      "Effect": "Allow",
//      "Resource": "*"
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_user_policy_attachment" "eks_gitlab_user_policy_attach" {
//  provider = aws.local
//  count    = local.enable_kubernetes_user_for_gitlab ? 1 : 0
//
//  user       = aws_iam_user.eks_gitlab_user[0].name
//  policy_arn = aws_iam_policy.eks_gitlab_user_policy[0].arn
//}
//
//resource "aws_iam_access_key" "eks_gitlab_user_key" {
//  provider = aws.local
//  count    = local.enable_kubernetes_user_for_gitlab ? 1 : 0
//
//  user = aws_iam_user.eks_gitlab_user[0].name
//}
//
//resource "gitlab_project_variable" "AWS_SHARED_CREDENTIALS_FILE" {
//  provider = gitlab.local
//  count    = local.enable_kubernetes_user_for_gitlab ? length(var.GITLAB_PROJECT_IDS) : 0
//
//  project           = var.GITLAB_PROJECT_IDS[count.index]
//  key               = "AWS_SHARED_CREDENTIALS_FILE"
//  variable_type     = "file"
//  value             = "[kube]\naws_default_region=${local.region}\naws_access_key_id=${aws_iam_access_key.eks_gitlab_user_key[0].id}\naws_secret_access_key=${aws_iam_access_key.eks_gitlab_user_key[0].secret}"
//  protected         = false
//  environment_scope = var.GITLAB_ENV_SCOPES[count.index]
//}
//
//# Push the kubernetes cluster name back to the git project
//resource "gitlab_project_variable" "kubernetes_cluster" {
//  provider = gitlab.local
//  count    = local.enable_kubernetes_user_for_gitlab ? length(var.GITLAB_PROJECT_IDS) : 0
//
//  project           = var.GITLAB_PROJECT_IDS[count.index]
//  key               = "KUBERNETES_CLUSTER"
//  variable_type     = "env_var"
//  value             = module.eks.eks_cluster_name
//  protected         = false
//  environment_scope = var.GITLAB_ENV_SCOPES[count.index]
//}
//
//# Push the aws region name back to the git project
//resource "gitlab_project_variable" "aws_region" {
//  provider = gitlab.local
//  count    = local.enable_kubernetes_user_for_gitlab ? length(var.GITLAB_PROJECT_IDS) : 0
//
//  project           = var.GITLAB_PROJECT_IDS[count.index]
//  key               = "AWS_REGION"
//  variable_type     = "env_var"
//  value             = local.region
//  protected         = false
//  environment_scope = var.GITLAB_ENV_SCOPES[count.index]
//}
//
//############
//# PROVIDERS
//############
//provider "gitlab" {
//  alias = "local"
//
//  token    = var.GITLAB_TOKEN
//  base_url = "https://git.nasdaq.com"
//}
//
