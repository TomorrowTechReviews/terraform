variable "vpc_id" {
  type        = string
  description = ""
  default     = ""
}

variable "ecs_cluster_name" {
  type        = string
  description = ""
  default     = "platform"
}

variable "fargate_weight" {
  description = "The relative percentage of the total number of launched tasks that should use the specified capacity provider"
  type        = number
  default     = 40
}

variable "fargate_spot_weight" {
  description = "The relative percentage of the total number of launched tasks that should use the specified capacity provider"
  type        = number
  default     = 60
}
