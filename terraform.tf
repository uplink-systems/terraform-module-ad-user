####################################################################################################
#   terraform.tf                                                                                   # 
####################################################################################################

terraform {
  required_providers {
    ad = {
      source  = "hashicorp/ad"
      version = "~> 0.5"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.3"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }
  }
}
