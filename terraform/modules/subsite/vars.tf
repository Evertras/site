variable "subdomain" {
  description = "The subdomain to apply"
  type        = string
}

variable "hosted_zone_id" {
  description = "The hosted zone ID in Route 53"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The main ACM certificate's ARN"
  type        = string
}
