terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "datadog_metrics_not_showing_up_in_ui_on_cluster_installation" {
  source    = "./modules/datadog_metrics_not_showing_up_in_ui_on_cluster_installation"

  providers = {
    shoreline = shoreline
  }
}