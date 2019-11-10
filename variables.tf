variable "location" {

}

variable "name" {
  default = null
}

variable "network" {
  default = "default"
}

variable "private_nodes" {
  default = false
}

variable "master_ipv4_cidr_block" {
  default = "172.16.0.0/28"
}
