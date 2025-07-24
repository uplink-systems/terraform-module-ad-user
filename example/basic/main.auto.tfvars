####################################################################################################
#   main.auto.tfvars                                                                               #
####################################################################################################

user = {
    "00001" = {
        principal_name              = "sepp.mueller@example.corp"
        sam_account_name            = "MuellerS"
        surname                     = "Müller"
        given_name                  = "Sepp"
        company                     = "Example Holding AG"
        country                     = "DE"
        state                       = "Bavaria"
        city                        = "Munich"
        postal_code                 = "80992"
        street_address              = "Pelkovenstrasse 140"
        container                   = "OU=Users,OU=DE,OU=ORG,DC=example,DC=corp"
        fax                         = "+49 89 1234 101"
        department                  = "Management Board"
        title                       = "CEO"
        custom_attributes           = {
            extensionAttribute1         = "AADSync"
        }
    }
    "00002" = {
        sam_account_name            = "MustermannM"
        surname                     = "Mustermann"
        given_name                  = "Max"
        company                     = "Example Germany GmbH"
        country                     = "DE"
        state                       = "Berlin"
        city                        = "Berlin"
        postal_code                 = "10119"
        street_address              = "Torstrasse 234"
        container                   = "OU=Users,OU=DE,OU=ORG,DC=example,DC=corp"
        department                  = "IT Infrastructure"
        title                       = "IT Administrator"
        principal_name_suffix       = "example.corp"
        custom_attributes           = {
            extensionAttribute1         = "AADSync"
            extensionAttribute2         = "RemoteUser"
        }
    }
}