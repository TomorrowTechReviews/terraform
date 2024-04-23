module "rds_aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name   = "main"
  engine = "aurora-postgresql"
  # serverless - Aurora Serverless v1 DB cluster
  # provisioned - Aurora Serverless v2 DB cluster
  engine_mode       = "provisioned"
  engine_version    = "14.5"
  storage_encrypted = true

  master_username = "root"
  database_name   = "chat"

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }

  monitoring_interval = 60
  apply_immediately   = true
  skip_final_snapshot = true

  serverlessv2_scaling_configuration = {
    min_capacity = 1
    max_capacity = 10
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
    two = {}
  }
}

resource "aws_ssm_parameter" "rds_host" {
  name        = "/rds/host"
  description = "RDS host"
  type        = "SecureString"
  value       = module.rds_aurora.cluster_endpoint
}

resource "aws_ssm_parameter" "rds_database_name" {
  name        = "/rds/name"
  description = "RDS database name"
  type        = "SecureString"
  value       = module.rds_aurora.cluster_database_name
}
