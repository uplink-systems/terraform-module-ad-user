####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "ad_user" {
  description = "output all user's attributes and values"
  value       = ad_user.user
}

output "ad_user_credential" {
  description = "ouput the user's upn, password and credential file path/name as map"
  value       = tomap({
    username        = ad_user.user.principal_name
    samaccountname  = ad_user.user.sam_account_name
    password        = nonsensitive(random_password.password.result)
    credential_file = length(local_sensitive_file.credential) > 0 ? local.export.filename : null
  })
}

output "ad_user_credential_csv" {
  description = "output the user's upn and password as comma-separated values"
  value       = "${ad_user.user.principal_name},${ad_user.user.sam_account_name},${nonsensitive(random_password.password.result)}"
}
