resource "shoreline_notebook" "datadog_metrics_not_showing_up_in_ui_on_cluster_installation" {
  name       = "datadog_metrics_not_showing_up_in_ui_on_cluster_installation"
  data       = file("${path.module}/data/datadog_metrics_not_showing_up_in_ui_on_cluster_installation.json")
  depends_on = [shoreline_action.invoke_dd_account_plan]
}

resource "shoreline_file" "dd_account_plan" {
  name             = "dd_account_plan"
  input_file       = "${path.module}/data/dd_account_plan.sh"
  md5              = filemd5("${path.module}/data/dd_account_plan.sh")
  description      = "Check your Datadog account plan limitations"
  destination_path = "/tmp/dd_account_plan.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_dd_account_plan" {
  name        = "invoke_dd_account_plan"
  description = "Check your Datadog account plan limitations"
  command     = "`chmod +x /tmp/dd_account_plan.sh && /tmp/dd_account_plan.sh`"
  params      = ["DATADOG_API_KEY"]
  file_deps   = ["dd_account_plan"]
  enabled     = true
  depends_on  = [shoreline_file.dd_account_plan]
}

