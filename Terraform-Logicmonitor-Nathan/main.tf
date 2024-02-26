variable "regions" {
  type = list(string)
  default = ["ATL", "AUSY", "AWS-E", "AWS-W","AWS-STG","BRU1","CNHK","DFW","FRA","JFK1","JFK2","Lab","LAX1","LAX2","RDU","YVR","YYZ"]
}

variable "bwi_pops" {
  type = list(string)
  default = ["TY001","TH2","LON1","DUB1","MIL1","MAD1","SG1","SG2","LS1","LU1","TYO1"]
}

variable "team_applies_to" {
  type = string
  default = "isTeamNetOpsObservability()"
}









resource "logicmonitor_device_group" "noobs-devices_by_type" {
  custom_properties = [
    {
      name = "isTerraformManaged"
      value = "true"
    }
  ]
  description = "Supergroup for organizing Noob team resources by their types"
  group_type = "Normal"
  name = "Devices by Type"
  parent_id = 3249 //Team Terraform Groups/NetOps Observability
  lifecycle {
    ignore_changes = [
      extra
    ]
  }
}

  resource "logicmonitor_device_group" "noobs-devices_by_type-collectors" {
    custom_properties = [
      {
        name = "isTerraformManaged"
        value = "true"
      }
    ]
    applies_to = "${var.team_applies_to} && isCollectorDevice()"
    description = "Group for collectors"
    group_type = "Normal"
    name = "Collectors"
    parent_id = logicmonitor_device_group.noobs-devices_by_type.id //3229 //Team Terraform Groups/Devices by Type
    lifecycle {
      ignore_changes = [
        extra
      ]
    }
  }


resource "logicmonitor_device_group" "noobs-devices_by_location" {
  custom_properties = [
    {
      name = "isTerraformManaged"
      value = "true"
    }
  ]
  description = "Supergroup for organizing Noob team resources by their physical locations"
  group_type = "Normal"
  name = "Devices by Location"
  parent_id = 3249 //Team Terraform Groups/NetOps Observability
  lifecycle {
    ignore_changes = [
      extra
    ]
  }
}


  resource "logicmonitor_device_group" "devices_by_region" {
    for_each = toset(var.regions)
    name = each.value
    description = "${each.value} datacenter"
    applies_to = "${var.team_applies_to} && system.displayname =~ \"${each.value}\""
    parent_id = logicmonitor_device_group.noobs-devices_by_location.id
  }

