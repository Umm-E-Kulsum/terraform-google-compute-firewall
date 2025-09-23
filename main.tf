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


resource "google_compute_firewall" "default" {
  project     = var.project_id
  name        = var.name
  network     = var.network
  description = var.description

  direction = var.direction
  priority  = var.priority
  disabled  = var.disabled

  dynamic "allow" {
    for_each = var.allow
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = var.deny
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }

  destination_ranges = var.destination_ranges
  source_ranges      = var.source_ranges

  // Conditional logic to prevent conflicting arguments
  source_tags             = length(var.source_tags) > 0 ? var.source_tags : null
  target_tags             = length(var.target_tags) > 0 ? var.target_tags : null
  source_service_accounts = length(var.source_service_accounts) > 0 ? var.source_service_accounts : null
  target_service_accounts = length(var.target_service_accounts) > 0 ? var.target_service_accounts : null

  log_config {
    metadata = var.log_config_metadata
  }

  lifecycle {
    precondition {
      condition     = length(var.source_tags) == 0 || length(var.source_service_accounts) == 0
      error_message = "The 'source_tags' and 'source_service_accounts' arguments are mutually exclusive."
    }
    precondition {
      condition     = length(var.target_tags) == 0 || length(var.target_service_accounts) == 0
      error_message = "The 'target_tags' and 'target_service_accounts' arguments are mutually exclusive."
    }
    precondition {
      condition     = length(var.allow) > 0 || length(var.deny) > 0
      error_message = "A firewall rule must have at least one 'allow' or 'deny' block."
    }
  }
}
