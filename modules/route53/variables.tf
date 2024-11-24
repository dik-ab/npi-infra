variable "region" {
  description = "AWS region for the Route 53 hosted zone"
  type        = string
}

variable "domain_name" {
  description = "The root domain name (e.g., example.com)"
  type        = string
}

variable "subdomain" {
  description = "The subdomain (e.g., www). Leave blank for root domain."
  type        = string
  default     = ""
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The Zone ID of the ALB"
  type        = string
}
