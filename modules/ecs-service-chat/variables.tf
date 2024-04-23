variable "vpc_id" {
  type        = string
  description = ""
  default     = ""
}

variable "alb_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "alb_zone_id" {
  type        = string
  description = ""
  default     = ""
}

variable "http_listener_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "https_listener_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "alb_domain" {
  type        = string
  description = ""
  default     = ""
}

variable "ecs_cluster_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "ecs_cluster_name" {
  type        = string
  description = ""
  default     = "platform"
}

variable "name" {
  type        = string
  description = ""
  default     = ""
}

variable "cpu" {
  type        = number
  description = ""
  default     = 512
}

variable "memory" {
  type        = number
  description = ""
  default     = 1024
}

variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = ""
}

variable "domain" {
  type        = string
  default     = ""
  description = ""
}

variable "subdomain" {
  type        = string
  default     = ""
  description = ""
}

variable "ecs_task_exec_role_arn" {
  type        = string
  default     = ""
  description = ""
}

variable "ecs_task_role_arn" {
  type        = string
  default     = ""
  description = ""
}

variable "subnets" {
  description = "A list of subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  type        = string
  default     = ""
  description = ""
}

variable "security_groups" {
  type        = list(string)
  description = ""
}

variable "asg_max_capacity" {
  type        = number
  description = ""
  default     = 2
}

variable "asg_min_capacity" {
  type        = number
  description = ""
  default     = 1
}

variable "asg_memory_target_value" {
  type        = number
  description = ""
  default     = 70
}

variable "asg_cpu_target_value" {
  type        = number
  description = ""
  default     = 70
}

variable "rds_secred_arn" {
  type        = string
  description = ""
}

variable "rds_host_ssm_arn" {
  type        = string
  description = ""
}

variable "rds_db_name_ssm_arn" {
  type        = string
  description = ""
}
