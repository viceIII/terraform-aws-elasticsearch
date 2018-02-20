variable "ebs_volume_size" {
  default = "10"
}

// Required
variable "name" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

# variable "zone_id" {}

// Optional
variable "elasticsearch_version" {
  default = "5.5"
}

variable "itype" {
  default = "t2.medium.elasticsearch"
}

variable "icount" {
  default = 1
}

variable "dedicated_master" {
  default = false
}

variable "mtype" {
  default = ""
}

variable "mcount" {
  default = 0
}

variable "zone_awareness" {
  default = false
}

variable "ingress_allow_security_groups" {
  default = []
}

variable "ingress_allow_cidr_blocks" {
  default = []
}

variable "rest_action_multi_allow_explicit_index" {
  default = "true"
}

variable "indices_fielddata_cache_size" {
  default = ""
}

variable "indices_query_bool_max_clause_count" {
  default = 1024
}

variable "snapshot_start" {
  default = 0
}

variable "aws_region" {}

variable "aws_account_id" {}
