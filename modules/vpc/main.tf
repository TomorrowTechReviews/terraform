module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_ipv6        = false
  enable_nat_gateway = true
  single_nat_gateway = true

  vpc_tags = {
    Name = var.name
  }
}
