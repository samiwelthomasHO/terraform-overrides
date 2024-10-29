locals {
  accounts = yamldecode(file("../accounts.yaml")).accounts
  accounts_by_ou = {for a in local.accounts: a.orgUnit => a...}
  accounts_by_env = {for a in local.accounts: a.env => a...}
  accounts_by_tenant = {for a in local.accounts: a.tenant => a...}

  defaults = yamldecode(file("../defaults.yaml")).defaults

  overrides = yamldecode(file("../overrides.yaml"))
  overrides_by_ou = local.overrides.orgUnit
  overrides_by_account = local.overrides.account

  features = values(local.features_by_account)
  features_by_account = {for a in local.accounts: a.name => {
    name = a.name
    orgUnit = a.orgUnit
    tenant = a.tenant
    env = a.env
    config = merge(
      local.defaults,
      lookup(local.overrides_by_ou, a.orgUnit, {}),
      lookup(local.overrides_by_account, a.name, {})
    )
  }}
  features_by_ou = {for a in local.features: a.orgUnit => a...}
  features_by_env = {for a in local.features: a.env => a...}
  features_by_tenant = {for a in local.features: a.tenant => a...}
}