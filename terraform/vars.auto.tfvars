account             = 202440332649
app_name            = "business-card"
aws_region          = "ap-northeast-1"
environment         = "prod"
solution_stack_name = "64bit Amazon Linux 2 v5.4.4 running Node.js 14"
tier                = "WebServer"
instance_type       = "t2.micro"
dns_name            = "fabasoad.com"
bucket_name         = "business-card-bucket"

# Policies
AWSElasticBeanstalkEnhancedHealth_arn                   = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
AWSElasticBeanstalkWebTier_arn                          = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
AWSElasticBeanstalkMulticontainerDocker_arn             = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
AWSElasticBeanstalkWorkerTier_arn                       = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
