output "account_features" {
  description = "The effective account feature configuration"
  value = local.features_by_account[var.accountName].config
}