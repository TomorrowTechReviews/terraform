variable "name" {
  type        = string
  description = ""
  default     = "custom"
}

variable "azs" {
  description = "A list of AZs"
  type        = list(string)
  default     = []
}
