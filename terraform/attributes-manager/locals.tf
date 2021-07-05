locals {
  application_name = "attributes-manager"
  deployment_name = "${local.application_name}-${timestamp()}.zip"
}