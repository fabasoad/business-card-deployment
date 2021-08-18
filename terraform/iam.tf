data "aws_iam_policy_document" "eb" {
  statement {
    sid     = ""
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["elasticbeanstalk"]
    }

    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eb" {
  name               = "${var.app_name}_eb_iam"
  assume_role_policy = data.aws_iam_policy_document.eb.json
  managed_policy_arns = [
    var.AWSElasticBeanstalkEnhancedHealth_arn,
    var.AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy_arn
  ]
}

data "aws_iam_policy_document" "ec2" {
  statement {
    sid     = ""
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "${var.app_name}_ec2_iam"
  assume_role_policy = data.aws_iam_policy_document.ec2.json
  managed_policy_arns = [
    var.AWSElasticBeanstalkWebTier_arn,
    var.AWSElasticBeanstalkMulticontainerDocker_arn,
    var.AWSElasticBeanstalkWorkerTier_arn
  ]
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.app_name}_ec2_instance_profile"
  role = aws_iam_role.ec2.name
}
