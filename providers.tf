# this file allows you to access AWS resources in your region,
# AWS resources in the universalservices account and also
# local resources from disk.

provider "aws" {
  alias  = "local"
  region = local.region

  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/${local.role_name}"
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "universalservices"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::659799195384:role/${local.role_name}"
    session_name = "universalservices"
  }
}

provider "aws" {
  alias  = "perimeter"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::454301813082:role/${local.role_name}"
    session_name = "perimeter"
  }
}
