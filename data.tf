data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    hostname     = "tfe.ops.nadq2universalservices.gi.nadq.ci"
    organization = "nasdaq"
    workspaces = {
      name = var.upstream_workspace
    }
  }
}
