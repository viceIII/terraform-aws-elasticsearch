output "endpoint" {
  value = "${aws_elasticsearch_domain.es.endpoint}"
}

output "elastic_arn" {
  value = "${aws_elasticsearch_domain.es.arn}"
}

output "security_group_id" {
  value = "${aws_security_group.elasticsearch.id}"
}
