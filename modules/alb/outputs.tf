output "alb_arn" {
  description = ""
  value       = aws_lb.alb.arn
}

output "alb_domain" {
  description = ""
  value       = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  description = ""
  value       = aws_lb.alb.zone_id
}

output "http_listener_arn" {
  description = ""
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = ""
  value       = aws_lb_listener.https.arn
}

output "acm_certificate_arn" {
  description = ""
  value       = module.acm.acm_certificate_arn
}
