variable "account" {
  description = "Account ID"
  type        = number
}
variable "app_name" {
  description = "Application name"
  type        = string
}
variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "environment" {
  description = "Environment (prod/stg/dev)"
  type        = string
}
variable "solution_stack_name" {
  description = "Stack that is used to host website"
  type        = string
}
variable "tier" {
  description = "Tier for EB"
  type        = string
}
variable "instance_type" {
  description = "Instance type for EC2 that is created by EB"
  type        = string
}
variable "dns_name" {
  description = "Website DNS name"
  type        = string
}
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}
variable "AWSElasticBeanstalkEnhancedHealth_arn" {
  description = "AWSElasticBeanstalkEnhancedHealth ARN"
  type        = string
}
variable "AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy_arn" {
  description = "AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy ARN"
  type        = string
}
variable "AWSElasticBeanstalkWebTier_arn" {
  description = "AWSElasticBeanstalkWebTier ARN"
  type        = string
}
variable "AWSElasticBeanstalkMulticontainerDocker_arn" {
  description = "AWSElasticBeanstalkMulticontainerDocker ARN"
  type        = string
}
variable "AWSElasticBeanstalkWorkerTier_arn" {
  description = "AWSElasticBeanstalkWorkerTier ARN"
  type        = string
}
