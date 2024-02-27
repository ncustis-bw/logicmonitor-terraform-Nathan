variable "LM_COMPANY" {
  sensitive = false
}

variable "LM_API_ID" {
  sensitive = true
}

variable "LM_API_KEY" {
  sensitive = true
}

provider "logicmonitor" {
  company = var.LM_COMPANY
  api_id = var.LM_API_ID
  api_key = var.LM_API_KEY
}


terraform {
  #  required_version = ">= 1.1.6"
  required_providers {
    logicmonitor = {
      source  = "logicmonitor/logicmonitor"
      version = "2.0.6"
    }
  }

}
