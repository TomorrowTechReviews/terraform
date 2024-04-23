variable "vpc_id" {
  type        = string
  description = ""
  default     = ""
}

variable "alb_name" {
  type        = string
  description = ""
  default     = "platform"
}

variable "subnets" {
  description = "A list of subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "hosted_zone" {
  type        = string
  description = ""
  default     = ""
}
