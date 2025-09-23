# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "google_service_account" "test_sa" {
  project      = var.project_id
  account_id   = "firewall-test-sa"
  display_name = "Firewall Test SA"
}

resource "google_compute_network" "sa_test_network" {
  project = var.project_id
  name    = "sa-test-network"
}

module "firewall_rule_for_sa" {
  source = "../../"

  project_id = var.project_id
  name       = "test-allow-for-sa"
  network    = google_compute_network.sa_test_network.self_link
  depends_on = [google_compute_network.sa_test_network]

  allow = [{
    protocol = "tcp"
    ports    = ["8080"]
  }]

  # Target the service account created above
  target_service_accounts = [google_service_account.test_sa.email]
  source_ranges           = ["0.0.0.0/0"]
}
