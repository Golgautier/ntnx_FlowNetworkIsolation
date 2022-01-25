This Terraform project allows to create automatically Nutanix Flow rules on an  Nutanix AHV Cluster, considering a dedicated category.

These configuration files will look at the [nutanix_category] category, and look at all the available values. Then, isolation rules will be created for ALL the value-pairs available to ensure that VM with these category are not able to communicate with the others using a different value.

Example : 
  Create a "Environment" category with 3 values : Production, Development, Test. Execute this script to create all isolation rules between Production, Development & Tests VM. 

Prerequisies : 
 - Nutanix AHV Cluster
 - Admin rights on Prism Central
 - Flow must be enabled on Prism Central
 

Variables to provide in a terraform.tfvars file :
- nutanix_enpoint : IP od the PRISM Central
- nutanix_password : password for the admin user
- nutanix_category : Category to parse to create isolation rules

Optional : 
- nutanix_user : admin username (Default : admin)
- nutanix_rulemode : mode to use for the created rules : MONITOR or APPLY. (Default : MONITOR)
