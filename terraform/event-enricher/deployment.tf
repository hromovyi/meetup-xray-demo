resource "null_resource" "build_script" {
  provisioner "local-exec" {
    command = <<EOF
      cd ../event-enricher
      npm i
      FUNCTION_NAME=${local.distribution_name} npm run package
EOF
  }

  triggers = {
    timestamp = timestamp()
  }
}