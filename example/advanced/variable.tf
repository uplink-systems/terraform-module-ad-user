####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "user" {
  description = "variable for user attributes to configure in AD"
  type        = map(object({
    given_name                  = string
    surname                     = string
    config_set                  = optional(string, null)
    container                   = optional(string, null)
    display_name                = optional(string, null)
    enabled                     = optional(bool, null)
    description                 = optional(string, null)
    company                     = optional(string, null)
    division                    = optional(string, null)
    department                  = optional(string, null)
    title                       = optional(string, null)
    organization                = optional(string, null)
    country                     = optional(string, null)
    state                       = optional(string, null)
    city                        = optional(string, null)
    postal_code                 = optional(string, null)
    principal_name              = optional(string, null)
    principal_name_suffix       = optional(string, null)
    street_address              = optional(string, null)
    office                      = optional(string, null)
    po_box                      = optional(string, null)
    other_name                  = optional(string, null)
    email_address               = optional(string, null)
    employee_id                 = optional(string, null)
    employee_number             = optional(string, null)
    home_directory              = optional(string, null)
    home_drive                  = optional(string, null)
    home_page                   = optional(string, null)
    office_phone                = optional(string, null)
    mobile_phone                = optional(string, null)
    home_phone                  = optional(string, null)
    fax                         = optional(string, null)
    id                          = optional(string, null)
    password_never_expires      = optional(bool, null)
    cannot_change_password      = optional(bool, null)
    sam_account_name            = optional(string, null)
    smart_card_logon_required   = optional(bool, null)
    trusted_for_delegation      = optional(bool, null)
    custom_attributes           = optional(map(string), {})
    export                      = optional(object({
      enabled                     = optional(bool, true)
      file                        = optional(string, null)
      path                        = optional(string, null)
    }), { enabled = true })
  }))
  default = {}
}

variable "config_set" {
  description = "variable for predefined config sets of attributes to configure"
  type        = map(object({
    company               = string
    country               = string
    state                 = string
    city                  = string
    postal_code           = string
    street_address        = string
    container             = string
    fax                   = string
    principal_name_suffix = string
  }))
  default = {
    "DE01"          = {
      company               = "Example Holding AG"
      country               = "DE"
      state                 = "Bavaria"
      city                  = "Munich"
      postal_code           = "80992"
      street_address        = "Pelkovenstrasse 140"
      container             = "OU=Users,OU=DE,OU=ORG,DC=example,DC=corp"
      fax                   = "+49 89 1234 101"
      principal_name_suffix = "example.corp"
    }
    "DE02"          = {
      company               = "Example Germany GmbH"
      country               = "DE"
      state                 = "Bavaria"
      city                  = "Munich"
      postal_code           = "80992"
      street_address        = "Pelkovenstrasse 140"
      container             = "OU=Users,OU=DE,OU=ORG,DC=example,DC=corp"
      fax                   = "+49 89 1234 201"
      principal_name_suffix = "de.example.corp"
    }
    "AT01"          = {
      company               = "Example Austria GmbH"
      country               = "AT"
      state                 = "Tyrol"
      city                  = "Kitzbuhel"
      postal_code           = "6370"
      street_address        = "Hornweg 9"
      container             = "OU=Users,OU=AT,OU=ORG,DC=example,DC=corp"
      fax                   = "+43 5356 4321 101"
      principal_name_suffix = "at.example.corp"
    }
  }
}
