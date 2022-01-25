variable "nutanix_endpoint" {
    type = string
    description = "Prism Central IP or FQDN"
}

variable "nutanix_username" {
    default = "admin"
    type = string
    description = "Admin user name for PC"
}

variable "nutanix_password" {
    type = string
    description = "Password for this admin user"
    sensitive = true
}

variable "nutanix_port" {
    default = "9440"
    type = number
    description = "Port de communication pour le PC"
  
}

variable "nutanix_category" {
    type = string
    description = "Category defining isolation"
}

variable "nutanix_rulemode" {
    type = string
    description = "Default mode for security Rule (MONITOR or APPLY)"
    default = "MONITOR"
}