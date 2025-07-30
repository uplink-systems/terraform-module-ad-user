####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  password  = {
    length            = try(var.password.length, 12)
    lower             = try(var.password.lower, true)
    min_lower         = try(var.password.min_lower, 1)
    min_numeric       = try(var.password.min_numeric, 1)
    min_special       = try(var.password.min_special, 1)
    min_upper         = try(var.password.min_upper, 1)
    numeric           = try(var.password.numeric, true)
    override_special  = try(var.password.override_special, "!#$%&*()-_=+[]{}<>:?")
    special           = try(var.password.special, true)
    upper             = try(var.password.upper, true)
  }
  user      = {
    export            = {
      surname           = lower(join("", [for character in split("", var.user.surname): lookup(var.character_map, character, character)]))
      given_name        = lower(join("", [for character in split("", var.user.given_name): lookup(var.character_map, character, character)]))
    }
    principal_name    = {
      surname           = lower(join("", [for character in split("", var.user.surname): lookup(var.character_map, character, character)]))
      given_name        = lower(join("", [for character in split("", var.user.given_name): lookup(var.character_map, character, character)]))
    }
    sam_account_name  = {
      surname           = substr(lower(join("", [for character in split("", var.user.surname): lookup(var.character_map, character, character)])), 0, 10)
      given_name        = substr(lower(join("", [for character in split("", var.user.given_name): lookup(var.character_map, character, character)])), 0, 2)
    }
  }
  export    = {
    filename    = (
      var.user.export.path != null && var.user.export.file != null ? "${var.user.export.path}/${var.user.export.file}" : (
        var.user.export.path == null && var.user.export.file != null ? "${path.root}/files/export/${var.user.export.file}" : (
          var.user.export.path != null && var.user.export.file == null ? "${var.user.export.path}/${local.user.export.surname}_${local.user.export.given_name}.txt" : (
            "${path.root}/files/export/${local.user.export.surname}_${local.user.export.given_name}.txt"
          )
        )
      )
    )
  }
}

