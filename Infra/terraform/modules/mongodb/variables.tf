variable "namespace" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_type" {
    type = string
}

variable "mongodb_region" {
    type = string
}

variable "mongodb_port" {
description = "Port used by the mongodb cluster."
type        = number
}

variable "ssh_key_path" {
  description = "Additional SSH Key Path"
  type        = string
}

variable "replica_set_name" {
  type = string
}
variable "mongodb_dns_hostnames" {
  description = "mongodb dns names for each replica set"
  type =  list(string)
}