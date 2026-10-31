
locals {
  common_tags = {
    Project        = "CCGC 5502 Terraform Project"
    Name           = var.student_name
    ExpirationDate = "2027-12-31"
    Environment    = var.environment
  }

  resource_group_name = "${var.humber_id}-RG"
}


module "rgroup" {
  source = "./modules/rgroup-9121"

  resource_group_name = local.resource_group_name
  location            = var.location
  tags                = local.common_tags
}


