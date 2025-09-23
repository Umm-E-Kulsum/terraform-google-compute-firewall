/**
 * Copyright 2021 Google LLC
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

variable "org_id" {
  description = "Org ID"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "Billing Account"
  type        = string
}

variable "shared_vpc" {
  description = "Shared VPC"
  type        = string
  default     = ""
}

variable "shared_vpc_subnets" {
  description = "Shared VPC subnets"
  type        = list(string)
  default     = []
}

variable "enable_shared_vpc_host_project" {
  description = "Enable Shared VPC"
  type        = bool
  default     = false
}
