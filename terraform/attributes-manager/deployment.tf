resource "null_resource" "build_script" {
  provisioner "local-exec" {
    command = <<EOF
      cd ../${local.application_name}
      rm -rf .gradle
      rm -rf build
      rm -rf dist
      mkdir dist
      zip -r dist/${local.application_name}.zip .
EOF
  }

  triggers = {
    timestamp = timestamp()
  }
}

resource "aws_s3_bucket_object" "deployment" {
  bucket = aws_s3_bucket.eb_artifacts.bucket
  key    = local.deployment_name
  source = "${path.root}/../${local.application_name}/dist/${local.application_name}.zip"

  depends_on = [null_resource.build_script]
}

resource "null_resource" "deploy_version" {
  provisioner "local-exec" {
    command = <<EOF
      aws elasticbeanstalk update-environment \
        --application-name ${aws_elastic_beanstalk_application.attributes_manager.name} \
        --version-label ${aws_elastic_beanstalk_application_version.deployed_version.name} \
        --environment-name ${aws_elastic_beanstalk_environment.attributes_manager_environment.name}
EOF
  }
  depends_on = [aws_elastic_beanstalk_application_version.deployed_version]
}