# terraform-google-google_compute_firewall

## Description

# Google Compute Firewall Module

This module allows you to create and manage a `google_compute_firewall` resource in Google Cloud Platform. It supports a wide range of firewall rule configurations, allowing for fine-grained control over network traffic to and from your VM instances.

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Usage

Basic usage of this module is as follows:

```hcl
module "firewall_rule" {
  source = "github.com/GoogleCloudPlatform/terraform-google-compute-firewall"

  project_id = "your-gcp-project-id"
  name       = "allow-ssh-from-iap"
  network    = "your-vpc-network-name"

  allow = [
    {
      protocol = "tcp"
      ports    = ["22"]
    }
  ]

  # This is the official IP range for IAP for TCP forwarding.
  source_ranges = ["35.235.240.0/20"]
}


Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow | A list of objects representing ALLOW rules. Each object should have a 'protocol' and an optional 'ports'. | <pre>list(object({<br>    protocol = string<br>    ports    = optional(list(string))<br>  }))</pre> | `[]` | no |
| deny | A list of objects representing DENY rules. Each object should have a 'protocol' and an optional 'ports'. | <pre>list(object({<br>    protocol = string<br>    ports    = optional(list(string))<br>  }))</pre> | `[]` | no |
| description | An optional description for this firewall rule. | `string` | `null` | no |
| destination\_ranges | A list of destination IP CIDR ranges to which this rule applies. (For EGRESS rules). | `list(string)` | `[]` | no |
| direction | The direction of traffic to which this firewall applies; either INGRESS or EGRESS. | `string` | `"INGRESS"` | no |
| disabled | If set to true, the firewall rule is not enforced. | `bool` | `false` | no |
| log\_config\_metadata | Controls whether metadata is included in firewall logs. Can be 'INCLUDE\_ALL\_METADATA' or 'EXCLUDE\_ALL\_METADATA'. | `string` | `"EXCLUDE_ALL_METADATA"` | no |
| name | The name of the firewall rule. The name must be 1-63 characters long, and comply with RFC1035. | `string` | n/a | yes |
| network | The name or self\_link of the VPC network to which this firewall rule will be applied. | `string` | n/a | yes |
| priority | Priority for this rule, from 0 to 65535. Lower numbers indicate higher priority. | `number` | `1000` | no |
| project\_id | The project ID where the firewall rule will be created. | `string` | n/a | yes |
| source\_ranges | A list of source IP CIDR ranges to which this rule applies. | `list(string)` | `[]` | no |
| source\_service\_accounts | A list of source service accounts. Cannot be used with source\_tags or target\_tags. | `list(string)` | `[]` | no |
| source\_tags | A list of source tags to which this rule applies. | `list(string)` | `[]` | no |
| target\_service\_accounts | A list of target service accounts. Cannot be used with source\_tags or target\_tags. | `list(string)` | `[]` | no |
| target\_tags | A list of target tags to which this rule applies. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| creation\_timestamp | The creation timestamp of the firewall rule in RFC3339 text format. |
| id | The unique identifier for the firewall rule resource. |
| name | The name of the created firewall rule. |
| self\_link | The self-referential URI of the created firewall rule. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

The following sections describe the requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform](https://www.terraform.io/downloads.html) v1.3 or later
- [Terraform Provider for GCP][terraform-provider-gcp] v5.4 or later

### Service Account

The service account used to run this module must have the following roles on the project where the firewall rule will be created:

*   Compute Security Admin: `roles/compute.securityAdmin`

### APIs

The following APIs must be enabled in the project:

*   Compute Engine API: `compute.googleapis.com`

[terraform-provider-gcp]: https://registry.terraform.io/providers/hashicorp/google/latest


## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
