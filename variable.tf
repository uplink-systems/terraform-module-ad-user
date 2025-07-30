####################################################################################################
#   variables.tf                                                                                   #
####################################################################################################

variable "password" {
  description   = "password policy values"
  default       = {}
}

variable "user" {
  description   = "user object values"
  type          = object({
    given_name                  = string
    surname                     = string
    cannot_change_password      = optional(bool, null)
    city                        = optional(string, null)
    company                     = optional(string, null)
    container                   = optional(string, null)
    country                     = optional(string, null)
    custom_attributes           = optional(map(string), {})
    department                  = optional(string, null)
    description                 = optional(string, null)
    display_name                = optional(string, null)
    division                    = optional(string, null)
    email_address               = optional(string, null)
    employee_id                 = optional(string, null)
    employee_number             = optional(string, null)
    enabled                     = optional(bool, null)
    fax                         = optional(string, null)
    home_directory              = optional(string, null)
    home_drive                  = optional(string, null)
    home_page                   = optional(string, null)
    home_phone                  = optional(string, null)
    id                          = optional(string, null)
    mobile_phone                = optional(string, null)
    office                      = optional(string, null)
    office_phone                = optional(string, null)
    organization                = optional(string, null)
    other_name                  = optional(string, null)
    password_never_expires      = optional(bool, null)
    po_box                      = optional(string, null)
    postal_code                 = optional(string, null)
    principal_name              = optional(string, null)
    principal_name_suffix       = optional(string, null)
    sam_account_name            = optional(string, null)
    smart_card_logon_required   = optional(bool, null)
    state                       = optional(string, null)
    street_address              = optional(string, null)
    title                       = optional(string, null)
    trusted_for_delegation      = optional(bool, null)
    export                      = optional(object({
      enabled                     = optional(bool, true)
      file                        = optional(string, null)
      path                        = optional(string, null)
    }), { enabled = true })
  })
  validation {
    condition     = var.user.principal_name == null ? true : can(length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user.principal_name)) > 0)
    error_message = <<-EOF
      Variable attribute 'principal_name' has an invalid value: ${var.user.principal_name == null ? 0 : var.user.principal_name}
      Value must be one of:
        RFC 822 based login UPN or null
    EOF
  }
  validation {
    condition     = var.user.principal_name_suffix == null ? true : can(length(regex("[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user.principal_name_suffix)) > 0)
    error_message = <<-EOF
      Variable attribute 'principal_name_suffix' has an invalid value: ${var.user.principal_name_suffix == null ? 0 : var.user.principal_name_suffix}
      Value must be one of:
        RFC 822 based login UPN suffix or null
    EOF
  }
  validation {
    condition     = (var.user.principal_name != null || var.user.principal_name_suffix != null) ? true : false
    error_message = <<-EOF
      Both variable attributes 'principal_name' and 'principal_name_suffix' have no value ('null').
      One of those attributes must contain a value other than 'null'.
    EOF
  }
  validation {
    condition     = var.user.email_address == null ? true : can(length(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user.email_address)) > 0)
    error_message = <<-EOF
      Variable attribute 'email_address' has an invalid value: ${var.user.email_address == null ? 0 : var.user.email_address}
      Value must be one of:
        RFC 5322 compliant email address or null
    EOF
  }
  validation {
    condition     = var.user.country == null ? true : can(regex("[A-Z][A-Z]", var.user.country))
    error_message = <<-EOF
      Variable attribute 'country' has an invalid value: ${var.user.country == null ? 0 : var.user.country}
      Value must be one of:
        2 upper-case character ISO 3166-1 country code or null
    EOF
  }
  validation {
    condition     = var.user.postal_code == null ? true : can(tonumber(var.user.postal_code))
    error_message = <<-EOF
      Variable attribute 'postal_code' has an invalid value: ${var.user.postal_code == null ? 0 : var.user.postal_code}
      Value must be one of:
        numerical data or null
    EOF
  }
}

variable "character_map" {
  description   = "character mapping values"
  type          = map
  default       = {
    "Ä"           = "Ae"
    "ä"           = "ae"
    "Á"           = "A"
    "á"           = "a"
    "À"           = "A"
    "à"           = "a"
    "Â"           = "A"
    "â"           = "a"
    "Ã"           = "A"
    "ã"           = "a"
    "Å"           = "A"
    "å"           = "a"
    "Ą"           = "A"
    "ą"           = "a"
    "Æ"           = "Ae"
    "æ"           = "ae"
    "Ć"           = "C"
    "ć"           = "c"
    "Ç"           = "C"
    "ç"           = "c"
    "Č"           = "C"
    "č"           = "c"
    "Ď"           = "D"
    "ď"           = "d"
    "Đ"           = "Dj"
    "đ"           = "dj"
    "È"           = "E"
    "É"           = "E"
    "é"           = "e"
    "è"           = "e"
    "Ê"           = "E"
    "ê"           = "e"
    "Ë"           = "E"
    "ë"           = "e"
    "Ę"           = "E"
    "ę"           = "e"
    "Í"           = "i"
    "í"           = "i"
    "Î"           = "I"
    "î"           = "i"
    "Ï"           = "i"
    "ï"           = "i"
    "Ĺ"           = "L"
    "ĺ"           = "l"
    "Ľ"           = "L"
    "ľ"           = "l"
    "Ł"           = "L"
    "ł"           = "l"
    "Ń"           = "N"
    "ń"           = "n"
    "Ň"           = "N"
    "ň"           = "n"
    "Ñ"           = "N"
    "ñ"           = "n"
    "Ö"           = "Oe"
    "ö"           = "oe"
    "Ó"           = "O"
    "ó"           = "o"
    "Ô"           = "O"
    "ô"           = "o"
    "Õ"           = "O"
    "õ"           = "o"
    "Œ"           = "Oe"
    "œ"           = "oe"
    "Ŕ"           = "R"
    "ŕ"           = "r"
    "Ś"           = "S"
    "ś"           = "s"
    "Š"           = "S"
    "š"           = "s"
    "Ş"           = "S"
    "ş"           = "s"
    "ß"           = "ss"
    "Ť"           = "T"
    "ť"           = "t"
    "Ü"           = "Ue"
    "ü"           = "ue"
    "Ú"           = "u"
    "ú"           = "u"
    "Ù"           = "U"
    "ù"           = "u"
    "Û"           = "U"
    "û"           = "u"
    "Ý"           = "Y"
    "ý"           = "y"
    "Ÿ"           = "Y"
    "ÿ"           = "y"
    "Ź"           = "Z"
    "ź"           = "z"
    "Ż"           = "Z"
    "ż"           = "z"
    "Ž"           = "Z"
    "ž"           = "z"
  }
}