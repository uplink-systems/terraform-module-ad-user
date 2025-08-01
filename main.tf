####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

resource "random_password" "password" {
  length                    = local.password.length >= 12 ? local.password.length : 12
  lower                     = local.password.lower
  min_lower                 = local.password.min_lower
  min_numeric               = local.password.min_numeric
  min_special               = local.password.min_special
  min_upper                 = local.password.min_upper
  numeric                   = local.password.numeric
  override_special          = local.password.override_special
  special                   = local.password.special
  upper                     = local.password.upper
}

resource "ad_user" "user" {
  display_name              = var.user.display_name == null ? format("%s, %s", var.user.surname, var.user.given_name) : var.user.display_name
  principal_name            = var.user.principal_name == null ? format("%s.%s@%s", local.user.principal_name.given_name, local.user.principal_name.surname, var.user.principal_name_suffix) : var.user.principal_name
  sam_account_name          = var.user.sam_account_name == null ? format("%s%s", local.user.sam_account_name.surname, local.user.sam_account_name.given_name) : var.user.sam_account_name
  cannot_change_password    = var.user.cannot_change_password == null ? false : var.user.cannot_change_password
  city                      = var.user.city
  company                   = var.user.company
  container                 = var.user.container
  country                   = var.user.country
  custom_attributes         = var.user.custom_attributes == null ? null : jsonencode(var.user.custom_attributes)
  department                = var.user.department
  description               = var.user.description
  division                  = var.user.division
  email_address             = var.user.email_address == null ? var.user.principal_name : var.user.email_address
  employee_id               = var.user.employee_id
  employee_number           = var.user.employee_number
  enabled                   = var.user.enabled == null ? true : var.user.enabled
  fax                       = var.user.fax
  given_name                = var.user.given_name
  home_directory            = var.user.home_drive == null ? null : var.user.home_directory
  home_drive                = var.user.home_directory == null ? null : var.user.home_drive
  home_phone                = var.user.home_phone
  home_page                 = var.user.home_page
  initial_password          = random_password.password.result
  initials                  = join("", [substr(var.user.given_name, 0, 1), substr(var.user.surname, 0, 1)])
  mobile_phone              = var.user.mobile_phone
  office                    = var.user.office
  office_phone              = var.user.office_phone
  organization              = var.user.organization
  other_name                = var.user.other_name
  password_never_expires    = var.user.password_never_expires == null ? false : var.user.password_never_expires
  po_box                    = var.user.po_box
  postal_code               = var.user.postal_code
  smart_card_logon_required = var.user.smart_card_logon_required == null ? false : var.user.smart_card_logon_required
  state                     = var.user.state
  street_address            = var.user.street_address
  surname                   = var.user.surname
  title                     = var.user.title
  trusted_for_delegation    = var.user.trusted_for_delegation == null ? false : var.user.trusted_for_delegation
  lifecycle {
    ignore_changes            = [ initial_password ]
  }
  depends_on                = [ random_password.password ]
}

resource "local_sensitive_file" "credential" {
  count                     = var.user.export.enabled == true ? 1 : 0
  content                   = <<-EOT
    ${ad_user.user.sam_account_name}
    ${ad_user.user.principal_name}
    ${nonsensitive(random_password.password.result)}
  EOT
  filename                  = local.export.filename
  depends_on                = [ ad_user.user ]
}
