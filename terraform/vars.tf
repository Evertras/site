variable "prefix" {
  description = "The namespace prefix to use"
  type        = string

  default = "evertras-com-site"
}

locals {
  domain = "evertras.com"
}
