|File|Description|
|----|-----------|
|data.tf|This file enables access to variables in `upstream_workspace` which were set when the environment was initially created, e.g. account_id, project code etc. They can be accessed with HCL similar to `${data.terraform_remote_state.network.environment}`|
|dev.auto.tfvars|A file with variable names and values which are specific for the development environment (as opposed to UAT or production). Put non-sensitive variables in this file to allow for version control of your variables.|
|eks.tf |This file creates the kubernetes cluster. Modules you can use are available and [documented here](https://bitbucket.org.nasdaqomx.com/projects/TEM). After initial deployment, you will probably want to enable [teleport](https://git.nasdaq.com/noc/wiki/-/wikis/K8sGuide-Teleport)|
|eks_cni_custom_networking.tf| Used to enable a nearly unlimited ip address space for kubernetes
|eks_cni_custom_networking.yaml| Used to enable a nearly unlimited ip address space for kubernetes
|kubernetes_user_for_gitlab.tf| If you want to push the IAM user credentials to a gitlab project for deploying gitlab created containers to this cluster, use this file.
|locals.tf|This gets common variables stored in `upstream_workspace` and surfaces them as easier to remember local variables such as `${local.environment}`|
|main.tf|This is the primary file for your terraform code.
|provider.tf|Configures terraform to talk with AWS (or Azure as appropriate)|
|variables.tf|Defines any mandatory variables you will use in any tf file which should be set either via workspace sharing (e.g. `upstream_workspace`) or via the `*.auto.tfvars` files or `TF_VAR_*` gitlab variables for sensitive data.|
