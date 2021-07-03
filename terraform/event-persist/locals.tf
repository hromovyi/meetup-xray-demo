locals {
  function_name     = "event-persist"
  distribution_name = "${local.function_name}-${timestamp()}"
}