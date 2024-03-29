data "aws_acm_certificate" "default" {
  domain      = var.dns_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_elastic_beanstalk_application" "default" {
  name        = "${var.app_name}-app"
  description = "Personal website"
  appversion_lifecycle {
    service_role          = aws_iam_role.eb.arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = filesha256(local.payload_path)
  application = aws_elastic_beanstalk_application.default.name
  description = "Application version created by terraform"
  bucket      = aws_s3_bucket.business_card_bucket.id
  key         = aws_s3_bucket_object.business_card_payload.id
}

#checkov:skip=CKV_AWS_312: To fix later
resource "aws_elastic_beanstalk_environment" "default" {
  name                = var.environment
  application         = aws_elastic_beanstalk_application.default.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier
  version_label       = aws_elastic_beanstalk_application_version.default.name
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "2"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2.arn
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = true
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = true
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = data.aws_acm_certificate.default.arn
  }
  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "ListenerEnabled"
    value     = false
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = true
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "HealthStreamingEnabled"
    value     = true
  }
  //  setting {
  //    namespace = "aws:elbv2:loadbalancer"
  //    name      = "SecurityGroups"
  //    value     = aws_security_group.lb_sg.arn
  //  }
}
