output "ecs_cluster_arn" {
  description = ""
  value       = aws_ecs_cluster.platform.arn
}

output "security_group_id" {
  description = ""
  value       = aws_security_group.ecs.id
}

output "ecs_task_exec_role_arn" {
  description = ""
  value       = aws_iam_role.ecs_task_exec_role.arn
}

output "ecs_task_role_arn" {
  description = ""
  value       = aws_iam_role.ecs_task_role.arn
}
