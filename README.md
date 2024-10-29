# Terraform Overrides Example

A repo that demonstrates how terraform resources can be optionally provisioned into a list of accounts using a predefined [default](./defaults.yaml) configuration.

To reduce the amount of configuration required, [overrides](./overrides.yaml) can be set at either the OU level or the individual account level, when deviations from the default configuration need to be configured.

This example repository uses a YAML file to provide a list of [accounts](./accounts.yaml), but the data could be sourced from anywhere.

## How it works?

Most of the logic happens in the [local.tf](./terraform/local.tf).

The list of accounts is read in, followed by the defaults and overrides.

The `features_by_account` local variable evaluates the effective set of configurations from least specific to most specific. i.e. if a value is set in an account level override, it will be used, otherwise, if a value is set in the OU override, it will be used. The default value will be used as a fallback if no override is detected.

The `main.tf` specifies which resources will get created, based on the feature configuration for that account. `null_resource` is used for illustrative purposes, but this could really be just about anything.

## How to use?

The example is designed to run for a single account at a time, making it suitable to run as part of a matrix job to target multiple accounts concurrently.

Navigate into the `terraform` directory.

```bash
cd terraform/
```

Run a terraform plan and apply as normal.

```bash
terraform plan -var accountName=account1
```

The account name should match one of the entries in [accounts.yaml](./accounts.yaml).

## Debugging

For convenience, other local variables have been created to allow inspection of the data using different dimensions e.g. by OU, by env name, by tenant etc.

These are not strictly needed, but can be useful to inspect and interrogate the data, for debugging purposes, whilst in a `terraform console` session.