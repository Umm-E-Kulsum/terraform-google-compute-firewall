/**
 * Copyright 2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The project ID where the firewall rule will be created."
  type        = string
}

variable "name" {
  description = "The name of the firewall rule. The name must be 1-63 characters long, and comply with RFC1035."
  type        = string
}

variable "network" {
  description = "The name or self_link of the VPC network to which this firewall rule will be applied."
  type        = string
}

variable "description" {
  description = "An optional description for this firewall rule."
  type        = string
  default     = ""
}

variable "direction" {
  description = "The direction of traffic to which this firewall applies; either INGRESS or EGRESS."
  type        = string
  default     = "INGRESS"
}

variable "priority" {
  description = "Priority for this rule, from 0 to 65535. Lower numbers indicate higher priority."
  type        = number
  default     = 1000
}

variable "disabled" {
  description = "If set to true, the firewall rule is not enforced."
  type        = bool
  default     = false
}

variable "allow" {
  description = "A list of objects representing ALLOW rules. Each object should have a 'protocol' and an optional 'ports'."
  type = list(object({
    protocol = string
    ports    = optional(list(string))
  }))
  default = []
}

variable "deny" {
  description = "A list of objects representing DENY rules. Each object should have a 'protocol' and an optional 'ports'."
  type = list(object({
    protocol = string
    ports    = optional(list(string))
  }))
  default = []
}

variable "destination_ranges" {
  description = "A list of destination IP CIDR ranges to which this rule applies. (For EGRESS rules)."
  type        = list(string)
  default     = []
}

variable "source_ranges" {
  description = "A list of source IP CIDR ranges to which this rule applies."
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "A list of source tags to which this rule applies."
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "A list of target tags to which this rule applies."
  type        = list(string)
  default     = []
}

variable "source_service_accounts" {
  description = "A list of source service accounts. Cannot be used with source_tags or target_tags."
  type        = list(string)
  default     = []
}

variable "target_service_accounts" {
  description = "A list of target service accounts. Cannot be used with source_tags or target_tags."
  type        = list(string)
  default     = []
}

variable "log_config_metadata" {
  description = "Controls whether metadata is included in firewall logs. Can be 'INCLUDE_ALL_METADATA' or 'EXCLUDE_ALL_METADATA'."
  type        = string
  default     = "EXCLUDE_ALL_METADATA"
}
