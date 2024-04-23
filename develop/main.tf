module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "platform"
  cidr = "10.0.0.0/16"

  azs              = ["eu-central-1a", "eu-central-1b"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"]

  enable_ipv6        = false
  enable_nat_gateway = true
  single_nat_gateway = false

  vpc_tags = {
    Name = "platform"
  }
}

module "alb" {
  source = "../modules/alb"

  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.public_subnets
  hosted_zone = "tomorrowtechreviews.com"
}

module "ecs" {
  source = "../modules/ecs"

  ecs_cluster_name    = "platform"
  vpc_id              = module.vpc.vpc_id
  fargate_weight      = 40
  fargate_spot_weight = 60
}
