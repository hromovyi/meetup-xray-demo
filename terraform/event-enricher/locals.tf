locals {
  function_name     = "event-enricher"
  distribution_name = "${local.function_name}-${timestamp()}"
}