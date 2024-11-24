output "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  value       = aws_route53_zone.zone.zone_id
}

output "route53_record_name" {
  description = "The DNS name of the record"
  value       = aws_route53_record.alias_record.name
}
