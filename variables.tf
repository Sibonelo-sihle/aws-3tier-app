variable "aws_region"           { default = "us-east-1" }
variable "project_name"         { default = "aws-3tier-app" }
variable "vpc_cidr"             { default = "10.0.0.0/16" }
variable "public_subnet_cidrs"  { default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "private_subnet_cidrs" { default = ["10.0.10.0/24", "10.0.11.0/24"] }
variable "instance_type"        { default = "t2.micro" }
variable "key_pair_name"        { type = string }
variable "ssh_allowed_cidr"     { type = string }
variable "db_name"              { default = "appdb" }
variable "db_username"          { default = "postgres" }
variable "db_password"          { type = string; sensitive = true }
