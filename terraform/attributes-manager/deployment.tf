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