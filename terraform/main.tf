
# This could be swapped out for some module
resource "null_resource" "a" {
  count = local.features_by_account[var.accountName].config.enableResourceA ? 1 : 0
  provisioner "local-exec" {
    command = "Creating resource A in ${var.accountName}"
  }
}

resource "null_resource" "b" {
  count = local.features_by_account[var.accountName].config.enableResourceB ? 1 : 0
  provisioner "local-exec" {
    command = "Creating resource B in ${var.accountName}"
  }
}

resource "null_resource" "additional" {
  for_each = { for r in local.features_by_account[var.accountName].config.additionalResources: r.name => r}
  provisioner "local-exec" {
    command = "Creating additional resource ${each.key}..."
  }
}