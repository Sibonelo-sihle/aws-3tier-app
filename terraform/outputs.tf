output "app_url" {
  value = "http://${aws_lb.main.dns_name}"
}

output "rds_endpoint" {
  value     = aws_db_instance.postgres.address
  sensitive = true
}

output "asg_name" {
  value = aws_autoscaling_group.app.name
}
