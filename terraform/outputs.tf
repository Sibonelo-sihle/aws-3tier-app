output "rds_endpoint" {
  value       = aws_db_instance.postgres.address
  sensitive   = true
  description = "RDS instance endpoint"
}

output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}