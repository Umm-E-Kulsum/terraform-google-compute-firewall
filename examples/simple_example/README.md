# Simple Example

This example illustrates how to use the `google_compute_firewall` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project ID to use for the test. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the created firewall rule. |
| project\_id | The project ID where the example resources were created. |
| self\_link | The self\_link of the created firewall rule. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
