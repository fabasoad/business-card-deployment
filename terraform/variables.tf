variable "app_name" {
  default     = "business-card"
  description = "Application name"
  type        = string
}
variable "aws_region" {
  default     = "ap-northeast-1"
  description = "AWS region"
  type        = string
}
variable "environment" {
  default     = "prod"
  description = "Environment (prod/stg/dev)"
  type        = string
}
variable "solution_stack_name" {
  default     = "64bit Amazon Linux 2 v5.4.4 running Node.js 14"
  description = "Stack that is used to host website"
  type        = string
}
variable "tier" {
  default     = "WebServer"
  description = "Tier for EB"
  type        = string
}
variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type for EC2 that is created by EB"
  type        = string
}
variable "dns_name" {
  default     = "fabasoad.com"
  description = "Website DNS name"
  type        = string
}
