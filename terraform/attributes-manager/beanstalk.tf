resource "aws_elastic_beanstalk_application" "attributes_manager" {
  name = local.application_name
}

resource "aws_elastic_beanstalk_environment" "attributes_manager_environment" {
  application         = aws_elastic_beanstalk_application.attributes_manager.name
  name                = "${aws_elastic_beanstalk_application.attributes_manager.name}-env"
  tier                = "WebServer"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.8 running Java 8"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = var.region
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.instance_profile.id
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = true
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "false"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:monitoring"
    name      = "Automatically Terminate Unhealthy Instances"
    value     = "false"
  }

  setting {
    namespace = "aws:elasticbeanstalk:xray"
    name      = "XRayEnabled"
    value     = "true"
  }
}

resource "aws_elastic_beanstalk_application_version" "deployed_version" {
  application = aws_elastic_beanstalk_application.attributes_manager.name
  bucket      = aws_s3_bucket.eb_artifacts.id
  key         = aws_s3_bucket_object.deployment.id
  name        = "Version-${uuid()}"
}
