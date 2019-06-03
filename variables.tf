variable "network" {

}
variable "location" {

}

variable "name" {
  default = null
}

variable "minimum_version" {
  default = "1.13"
}

variable "private_nodes" {
  default = false
}

variable "master_ipv4_cidr_block" {
  default = "172.16.0.0/28"
}

# https://github.com/terraform-providers/terraform-provider-google/issues/3369#issuecomment-497819347
variable "issue_client_certificate" {
  default = false
}
