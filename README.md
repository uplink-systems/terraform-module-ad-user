## Module 'terraform-module-ad-user'

### Description

The module **terraform-module-ad-user** is intended to create user accounts in an onprem Active Directory following my business needs and standards. The module scopes all attributes available in the provider. It is designed to handle multiple users or even all users using for_each loop in the root module.  
  
The module uses the following guidelines and rules by default to create its values:  
* sAMAccountName
  * the <code>sam_account_name</code> attribute consists of a combination of <code>surname</code>- and <code>given_name</code>-attribute.
    * the <code>surname</code> attribute is cut-off after max. 10 characters
    * the <code>given_name</code> attribute is cut-off after max. 2 characters
* User Principal Name
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
| <a name="input_password"></a> [password](#input\_user) | 'var.password' is the optional variable for random_password settings (password policy) | <pre> tbd </pre> | {} | no |
| <a name="input_user"></a> [user](#input\_user) | 'var.user' is the main variable for ad_user resource settings | <pre> tbd </pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ad_user"></a> [ad\_user](#output\_ad\_user) | list of all exported attributes values from all users |
| <a name="output_ad_user_credential"></a> [ad\_user\_credential](#output\_ad\_user\_credential) | list of exported ad_user.user.principal_name, random_password.password.result and local_sensitive_file.credential[0].filename attribute values as map from all users |
| <a name="output_ad_user_credential_csv"></a> [ad\_user\_credential\_csv](#output\_ad\_user\_credential\_csv) | list of exported ad_user.principal_name and random_password.password.result attribute values as comma-separated values from all users |

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
