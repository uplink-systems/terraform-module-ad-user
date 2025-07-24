####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

module "ad_user" {
  source      = "github.com/uplink-systems/terraform-module-ad-user"
  for_each    = var.user
  user        = {
    given_name                  = each.value.given_name
    surname                     = each.value.surname
    cannot_change_password      = each.value.cannot_change_password
    city                        = each.value.city
    company                     = each.value.company
    container                   = each.value.container
    country                     = each.value.country
    custom_attributes           = each.value.custom_attributes
    department                  = each.value.department
    description                 = each.value.description
    division                    = each.value.division
    email_address               = each.value.email_address
    employee_id                 = each.value.employee_id
    employee_number             = each.value.employee_number
    enabled                     = each.value.enabled
    fax                         = each.value.fax
    home_directory              = each.value.home_directory
    home_drive                  = each.value.home_drive
    home_page                   = each.value.home_page
    home_phone                  = each.value.home_phone
    id                          = each.value.id
    mobile_phone                = each.value.mobile_phone
    organization                = each.value.organization
    office                      = each.value.office
    office_phone                = each.value.office_phone
    other_name                  = each.value.other_name
    password_never_expires      = each.value.password_never_expires
    po_box                      = each.value.po_box
    postal_code                 = each.value.postal_code
    principal_name              = each.value.principal_name
    principal_name_suffix       = each.value.principal_name_suffix
    sam_account_name            = each.value.sam_account_name
    smart_card_logon_required   = each.value.smart_card_logon_required
    state                       = each.value.state
    street_address              = each.value.street_address
    title                       = each.value.title
    trusted_for_delegation      = each.value.trusted_for_delegation
  }
}