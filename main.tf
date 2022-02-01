
# Identify resources
data "nutanix_subnet" "subnet" {
  subnet_name = var.nutanix_network
}

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster
}

# Get values from category
data "nutanix_category_key" "Categorie"{
    name = var.nutanix_category
}

# Construct pairs by set the product of the category value, then ordering pairs and keeping only pairs with different values
locals {
  MyListTMP = [
    for pair in setproduct(data.nutanix_category_key.Categorie.values,data.nutanix_category_key.Categorie.values) : sort([ pair[0] , pair[1] ]) if pair[0] != pair[1] 
  ]

  MyProperList = { for idx, val in distinct(local.MyListTMP) : idx => val }
}

# Create Security policy for isolation
resource "nutanix_network_security_rule" "IsolationRule" {

  for_each =  local.MyProperList

  # Name & Description
  name            = "Iso-${each.value[0]}-${each.value[1]}"
  description     = "Isolation for VM categorized ${each.value[0]} and ${each.value[1]} for category ${var.nutanix_category}"

  #Mode Monitoring
  isolation_rule_action = var.nutanix_rulemode

  #1st category to isolate
  isolation_rule_first_entity_filter_kind_list  = ["vm"]
  isolation_rule_first_entity_filter_type = "CATEGORIES_MATCH_ALL"
  isolation_rule_first_entity_filter_params {
    name   = var.nutanix_category
    values = [each.value[0]]
  }

  #2nd category to isolate
  isolation_rule_second_entity_filter_kind_list = ["vm"]
  isolation_rule_second_entity_filter_type = "CATEGORIES_MATCH_ALL"
  isolation_rule_second_entity_filter_params {
    name   = var.nutanix_category
    values = [each.value[1]]
  }
  
}
