data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  account = data.aws_caller_identity.current.account_id
  region  = data.aws_region.current.name

  rds_host     = "arn:aws:ssm:${local.region}:${local.account}:parameter/rds/host"
  rds_name     = "arn:aws:ssm:${local.region}:${local.account}:parameter/rds/name"
  rds_password = "arn:aws:ssm:${local.region}:${local.account}:parameter/rds/password"
  rds_user     = "arn:aws:ssm:${local.region}:${local.account}:parameter/rds/user"

  log_group_name = "/ecs/${var.name}"
  service_name   = var.name
  container_name = var.name
}
