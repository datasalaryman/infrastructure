provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "zone_id" {
  type = string
  description = "route 53 zone id for this route"
}

variable "record_file" {
  type = string
  description = "file containing the record config in json format"
}

resource "aws_route53_record" "record" {
  for_each = {for record in local.records_json: join("", [record["Name"], "-", record["Type"]]) => record}
  zone_id = var.zone_id
  name    = each.value["Name"]
  type    = each.value["Type"]
  ttl     = lookup(each.value, "TTL", null)

  dynamic alias {
    for_each = lookup(each.value, "AliasTarget", null) == null ? [] : [each.value["AliasTarget"]]
    content {
        name                   = alias.value["DNSName"]
        zone_id                = alias.value["HostedZoneId"]
        evaluate_target_health = alias.value["EvaluateTargetHealth"]
    }
  }

  records = lookup(each.value, "ResourceRecords", null) != null ? [for destination in each.value["ResourceRecords"]: destination["Value"]] : null
}