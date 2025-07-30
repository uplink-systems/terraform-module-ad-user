## Module 'terraform-module-ad-user'

> [!CAUTION]
>The module is currently in BETA state and not finally tested!  
>USE AT YOUR OWN RISK!!  

### Description

The module **terraform-module-ad-user** is intended to create user accounts in an onprem Active Directory following my business needs and standards. The module scopes all attributes available in the provider. It is designed to handle multiple users or even all users using for_each loop in the root module.  
  
The module uses the following guidelines and rules by default to create its values:  
* sAMAccountName
  * the <code>sam_account_name</code> attribute must not have any language-specific 'special' characters; the module contains a function to translate 'special' characters to 'normal' characters; the map is a variable and can be customised
  * the <code>sam_account_name</code> attribute consists of a combination of <code>surname</code>- and <code>given_name</code>-attribute.
    * the <code>surname</code> attribute is cut-off after max. 10 characters
    * the <code>given_name</code> attribute is cut-off after max. 2 characters
* User Principal Name
  * the <code>principal_name</code> attribute must not have any language-specific 'special' characters; the module contains a function to translate 'special' characters to 'normal' characters; the map is a variable and can be customised
  * the <code>principal_name</code> attribute consist of a combination of <code>given_name</code>-, <code>surname</code>- and <code>upn_suffix</code>-attribute.
  
> [!WARNING]
>The module's outputs may expose sensitive data like user credentials in the CLI as well as in the file system.  
>Therefore it should only be used by trusted admins and store its output to highly restricted locations.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ad"></a> [hashicorp\/ad](#requirement\_ad) | ~> 0.5 |
| <a name="requirement_local"></a> [hashicorp\/local](#requirement\_local) | ~> 2.5 |
| <a name="requirement_random"></a> [hashicorp\/random](#requirement\_random) | ~> 3.6 |

### Resources

| Name | Type |
|------|------|
| [ad_user.user](https://registry.terraform.io/providers/hashicorp/ad/latest/docs/resources/user) | resource |
| [local_sensitive_file.credential](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password"></a> [password](#input\_user) | 'var.password' is the optional variable for random_password settings ("password policy") | <pre>type = any</pre> | {} | no |
| <a name="input_user"></a> [user](#input\_user) | 'var.user' is the main variable for ad_user resource settings | <pre>type          = object({<br>  given_name                  = string<br>  surname                     = string<br>  cannot_change_password      = optional(bool, null)<br>  city                        = optional(string, null)<br>  company                     = optional(string, null)<br>  container                   = optional(string, null)<br>  country                     = optional(string, null)<br>  custom_attributes           = optional(map(string), {})<br>  department                  = optional(string, null)<br>  description                 = optional(string, null)<br>  display_name                = optional(string, null)<br>  division                    = optional(string, null)<br>  email_address               = optional(string, null)<br>  employee_id                 = optional(string, null)<br>  employee_number             = optional(string, null)<br>  enabled                     = optional(bool, null)<br>  fax                         = optional(string, null)<br>  home_directory              = optional(string, null)<br>  home_drive                  = optional(string, null)<br>  home_page                   = optional(string, null)<br>  home_phone                  = optional(string, null)<br>  id                          = optional(string, null)<br>  mobile_phone                = optional(string, null)<br>  office                      = optional(string, null)<br>  office_phone                = optional(string, null)<br>  organization                = optional(string, null)<br>  other_name                  = optional(string, null)<br>  password_never_expires      = optional(bool, null)<br>  po_box                      = optional(string, null)<br>  postal_code                 = optional(string, null)<br>  principal_name              = optional(string, null)<br>  principal_name_suffix       = optional(string, null)<br>  sam_account_name            = optional(string, null)<br>  smart_card_logon_required   = optional(bool, null)<br>  state                       = optional(string, null)<br>  street_address              = optional(string, null)<br>  title                       = optional(string, null)<br>  trusted_for_delegation      = optional(bool, null)<br>  export                      = optional(object({<br>    enabled                     = optional(bool, true)<br>    file                        = optional(string, null)<br>    path                        = optional(string, null)<br>  }), { enabled = true })<br>})</pre> | none | yes |
| <a name="input_character_map"></a> [character\_map](#input\_character_map) | 'var.character_map' is an optional variable to translate country specific characters in surnames and given names to 'default' characters for sAMAccountName or UPN | <pre>type = map</pre> | <pre>{<br>  "Ä"  = "Ae"<br>  "ä"  = "ae"<br>  "Á"  = "A"<br>  "á"  = "a"<br>  "À"  = "A"<br>  "à"  = "a"<br>  "Â"  = "A"<br>  "â"  = "a"<br>  "Å"  = "A"<br>  "å"  = "a"<br>  "Ą"  = "A"<br>  "ą"  = "a"<br>  "Æ"  = "Ae"<br>  "æ"  = "ae"<br>  "Ć"  = "C"<br>  "ć"  = "c"<br>  "Ç"  = "C"<br>  "ç"  = "c"<br>  "Č"  = "C"<br>  "č"  = "c"<br>  "Ď"  = "D"<br>  "ď"  = "d"<br>  "Đ"  = "Dj"<br>  "đ"  = "dj"<br>  "È"  = "E"<br>  "É"  = "E"<br>  "é"  = "e"<br>  "è"  = "e"<br>  "Ê"  = "E"<br>  "ê"  = "e"<br>  "Ë"  = "E"<br>  "ë"  = "e"<br>  "Ę"  = "E"<br>  "ę"  = "e"<br>  "Í"  = "i"<br>  "í"  = "i"<br>  "Î"  = "I"<br>  "î"  = "i"<br>  "Ï"  = "i"<br>  "ï"  = "i"<br>  "Ĺ"  = "L"<br>  "ĺ"  = "l"<br>  "Ľ"  = "L"<br>  "ľ"  = "l"<br>  "Ł"  = "L"<br>  "ł"  = "l"<br>  "Ń"  = "N"<br>  "ń"  = "n"<br>  "Ň"  = "N"<br>  "ň"  = "n"<br>  "Ñ"  = "N"<br>  "ñ"  = "n"<br>  "Ö"  = "Oe"<br>  "ö"  = "oe"<br>  "Ó"  = "O"<br>  "ó"  = "o"<br>  "Ô"  = "O"<br>  "ô"  = "o"<br>  "Œ"  = "Oe"<br>  "œ"  = "oe"<br>  "Ŕ"  = "R"<br>  "ŕ"  = "r"<br>  "Ś"  = "S"<br>  "ś"  = "s"<br>  "Š"  = "S"<br>  "š"  = "s"<br>  "Ť"  = "T"<br>  "ť"  = "t"<br>  "ß"  = "ss"<br>  "Ü"  = "Ue"<br>  "ü"  = "ue"<br>  "Ú"  = "u"<br>  "ú"  = "u"<br>  "Ù"  = "U"<br>  "ù"  = "u"<br>  "Û"  = "U"<br>  "û"  = "u"<br>  "Ý"  = "Y"<br>  "ý"  = "y"<br>  "Ÿ"  = "Y"<br>  "ÿ"  = "y"<br>  "Ź"  = "Z"<br>  "ź"  = "z"<br>  "Ż"  = "Z"<br>  "ż"  = "z"<br>  "Ž"  = "Z"<br>  "ž"  = "z"<br>}</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ad_user"></a> [ad\_user](#output\_ad\_user) | list of all exported attributes values from all users |
| <a name="output_ad_user_credential"></a> [ad\_user\_credential](#output\_ad\_user\_credential) | list of exported ad_user.user.principal_name, ad_user.user.sam_account_name, random_password.password.result and local_sensitive_file.credential[0].filename attribute values as map from all users |
| <a name="output_ad_user_credential_csv"></a> [ad\_user\_credential\_csv](#output\_ad\_user\_credential\_csv) | list of exported ad_user.principal_name, ad_user.user.sam_account_name and random_password.password.result attribute values as comma-separated values from all users |

>[!IMPORTANT]
>Apart from that the module exports each user's username and passwort physically as text file by default using 'local_sensitive_file' resources (export can be prevented by setting *var.user.export.enabled* value to 'false'). Path and filename have default values but can be modified by configuring *var.user.export.path* and *var.user.export.file* (see section \"Variables / Locals\").

<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - UPNs of all users using 'ad_user' output:  

```
output "ad_user_user_principal_name" {
  value   = values(module.ad_user).*.ad_user.principal_name
}
```

Output - SIDss of all users using 'ad_user' output:  

```
output "ad_user_user_sid" {
  value   = values(module.ad_user).*.ad_user.sid
}
```

Output - Distinguished Name of a specified users using 'ad_user' output:  

```
output "ad_user_user_distinguished_name" {
  value   = values(module.ad_user).["UserXYZ"].ad_user.dn
}
```

Output - Credential details of all users using 'ad_user_credential' output:

```
output "ad_user_credentials" {
  value   = values(module.ad_user).*.ad_user_credential
}
```
</details>

### Known Issues

Known issues are documented with the GitHub repo's issues functionality. Please filter the issues by **Types** and select **Known Issue** to get the appropriate issues and read the results carefully before using the module to avoid negative impacts on your infrastructure.  
  
<a name="known_issues"></a> [list of Known Issues](https://github.com/uplink-systems/terraform-module-ad-user/issues?q=type%3A%22known%20issue%22)

## Notes

### Variables / Locals

#### 'var.user.given_name'

The value for *var.user.given_name* is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'display_name' and (optionally) 'principal_name' attributes. *local.user.given_name* transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.surname'

The value for *var.user.surname* is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'display_name' and (optionally) 'principal_name' attributes. *local.user.surname* transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.sam_account_name'

The value for *var.user.sam_account_name* is mandatory.  

#### 'var.user.principal_name' / 'var.user.principal_name_suffix'

The values for *var.user.principal_name* and *var.user.principal_name_suffix* are optional. Nevertheless, the module requires that one of those attributes MUST have a value. For a static UPN the attribute *var.user.principal_name* must have a value, for a dynamically generated UPN (using the mandatory given_name and surname values) the attribute *var.user.principal_name_suffix* must have a value. A validation rule stopps the processing if both values are null.  

#### 'var.user.display_name'

The value for *var.user.display_name* is optional. The module has auto-build rules for users' *var.user.display_name* using the provided *var.user.surname*/*var.user.given_name* values. Therefore, *var.user.display_name* must be specified only if the rule shall not apply.  

**'var.user.custom_attributes'**
  
Custom attributes can be configured besides the default attributes. The variable must use the following syntaxes:  
  
<pre>
# example 1 (multi-line)
custom_attributes           = {
   comment                     = "single-value attribute example"
   carLicense                  = ["multi-value", "attribute", "example"]
}
# example 2 (single-line)
custom_attributes           = { extensionAttribute1 ="M365Synced", extensionAttribute2 = "HasNothingToDo" }
</pre>

#### 'var.user.export'

The value of *var.user.export.enabled* specifies if the module exports the user's credentials to an output file (true) or not (false). The default value is 'true' if no other value is provided. The values for *var.user.export.path* and *var.user.export.file* represent the path and name of the credential export file to create. The module has a default value \"${path.root}/files/export/azuread/user\" for *var.user.export.path* and an auto-build rule for *var.user.export.file* using the created *local.given_names*, *local.surname* values.
Therefore, *var.user.export.enabled* must be specified only if credentials shall not be exported and *var.user.export.path* and/or *var.user.export.file* only if the value/rule shall not apply.  

**'var.user.export.path'**  

The value for *var.user.export.path* must be in Unix style (using forward slashes) even if Terraform is running on Windows.  
Examples for valid paths:  

<pre>
/terraform/files/output
./terraform/files/output
../terraform/files/output
C:/terraform/files/output
</pre>

## Examples

Two examples how to use the module are part of the repository.  
The basic example indicates a straightforward configuration in a small environment, whereas the advanced example represents a more complex configuration in a large environment.  
The advanced example shows how I use the module in one of my work environments with more than a thousand users spread across multiple global locations and subsidiaries. To avoid input errors and unnecessarily bloated code, as well as to simplify mass changes, I use an additional variable 'config_set' for this case that contains predefined default values for each location/subsidiary, such as company name, country, address, and so on (list can be extended as needed). The configured values are preselected by a single attribute 'config_set' in the respective 'user' variable. The individual default values of the 'config_set' variable can be overridden by specifying the individual values in the respective 'user' variable or can completely ignored by not specifying any value for the 'user' variable 'config_set' attribute. That makes it a standards-based setup but keeps it highly flexible.  
