locals {
  main_domain = "evertras.com"

  full_domain = "${var.subdomain}.${local.main_domain}"

  tags = {
    Subdomain = var.subdomain
  }
}
