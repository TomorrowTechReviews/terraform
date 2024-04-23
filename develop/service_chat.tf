module "service_chat" {
  source = "../modules/ecs-service-chat"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  alb_arn             = module.alb.alb_arn
  alb_zone_id         = module.alb.alb_zone_id
  alb_domain          = module.alb.alb_domain
  http_listener_arn   = module.alb.http_listener_arn
  https_listener_arn  = module.alb.https_listener_arn
  acm_certificate_arn = module.alb.acm_certificate_arn

  cpu    = 512
  memory = 1024

  asg_min_capacity        = 1
  asg_max_capacity        = 2
  asg_cpu_target_value    = 40
  asg_memory_target_value = 40

  ecs_cluster_name       = "platform"
  ecs_cluster_arn        = module.ecs.ecs_cluster_arn
  ecs_task_exec_role_arn = module.ecs.ecs_task_exec_role_arn
  ecs_task_role_arn      = module.ecs.ecs_task_role_arn
  security_groups        = [module.ecs.security_group_id]

  rds_secred_arn      = module.rds_aurora.cluster_master_user_secret[0].secret_arn
  rds_host_ssm_arn    = aws_ssm_parameter.rds_host.arn
  rds_db_name_ssm_arn = aws_ssm_parameter.rds_database_name.arn

  name       = "chat"
  aws_region = "eu-central-1"
  domain     = "tomorrowtechreviews.com"
  subdomain  = "api"
}
