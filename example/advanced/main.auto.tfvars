####################################################################################################
#   main.auto.tfvars                                                                               #
####################################################################################################

user = {
    # example: user with full auto config set DE01
    "00001" = {
        principal_name              = "sepp.mueller@example.corp"
        sam_account_name            = "MuellerS"
        surname                     = "Müller"
        given_name                  = "Sepp"
        config_set                  = "DE01"
        title                       = "CEO"
        department                  = "Management Board"
        custom_attributes           = {
            extensionAttribute1         = "AADSync"
        }
    }
    # example: user with full auto config set AT01
    "00002" = {
        principal_name              = "johanna.meier@example.corp"
        sam_account_name            = "MeierJ"
        surname                     = "Meier"
        given_name                  = "Johanna"
        config_set                  = "AT01"
        department                  = "Administration"
        title                       = "Accountant"
        custom_attributes           = {
            extensionAttribute1         = "AADSync"
        }
    }
    # example: user with mixed config set DE02 and manual
    "00003" = {
        principal_name              = "knut.hansen@example.corp"
        sam_account_name            = "HansenK"
        surname                     = "Hansen"
        given_name                  = "Knut"
        config_set                  = "DE02"
        state                       = "Hamburg"
        city                        = "Hamburg"
        postal_code                 = "20359"
        street_address              = "Reeperbahn 157"
        department                  = "Development"
        title                       = "Software Developer"
        office_phone                = "+49 89 1234 567"
        custom_attributes           = {
            extensionAttribute1         = "AADSync"
            extensionAttribute2         = "RemoteUser"
        }
    }
    # example: user with full manual config
    "00004" = {
        principal_name              = "max.mustermann@example.corp"
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
        custom_attributes           = {
            extensionAttribute1         = "AADSync"
            extensionAttribute2         = "RemoteUser"
        }
    }
}