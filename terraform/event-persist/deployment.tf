resource "null_resource" "build_script" {
  provisioner "local-exec" {
    command = <<EOF
      cd ../${local.function_name}
      npm i
      FUNCTION_NAME=${local.distribution_name} npm run package
EOF
  }

  triggers = {
    timestamp = timestamp()
  }
}