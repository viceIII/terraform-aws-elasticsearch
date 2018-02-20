resource "aws_security_group" "elasticsearch" {
  name        = "${var.name} elasticsearch"
  description = "Security Group to allow traffic to ElasticSearch"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.name}"
  elasticsearch_version = "${var.elasticsearch_version}"

  cluster_config {
    instance_type            = "${var.itype}"
    instance_count           = "${var.icount}"
    dedicated_master_enabled = "${var.dedicated_master}"
    dedicated_master_type    = "${var.mtype}"
    dedicated_master_count   = "${var.mcount}"
    zone_awareness_enabled   = "${var.zone_awareness}"
  }

  vpc_options {
    security_group_ids = ["${aws_security_group.elasticsearch.id}"]
    subnet_ids         = ["${var.subnet_ids}"]
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "${var.rest_action_multi_allow_explicit_index}"
    "indices.fielddata.cache.size"           = "${var.indices_fielddata_cache_size}"
    "indices.query.bool.max_clause_count"    = "${var.indices_query_bool_max_clause_count}"
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = "${var.ebs_volume_size}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.snapshot_start}"
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${var.aws_region}:${var.aws_account_id}:domain/${var.name}/*"
    }
  ]
}
CONFIG
}
