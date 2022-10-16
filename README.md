# Evertras.com

The code and deployment for [evertras.com](https://evertras.com). This is more
for funsies than as a serious site with a single purpose, and is used generally
as a playground and reference for setting up cloud infrastructure and tooling.

## Tools

### AWS

Sets up hosting via S3 -> CloudFront using ACM to generate and manage a
certificate. Domain registration is done through an external site.

### Terraform

Gold standard of IaC deployment tooling. Terraform code is bundled with this
repo for simplicity's sake. This may be split into another repo in the future.
Currently only targeting "production", may add other environments later.

### Hugo

Generates a static site. Since I don't want to pay $3,000,000 for sneezing the
wrong way with EC2 instances, let's keep things simple and static so it's cheap
and easy to host via S3/Cloudfront alone.
