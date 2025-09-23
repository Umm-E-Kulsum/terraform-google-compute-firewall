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

resource "google_compute_network" "deny_test_network" {
  project = var.project_id
  name    = "deny-test-network"
}
module "deny_all_ingress" {
  source        = "../../"
  project_id    = var.project_id
  name          = "test-deny-all-ingress"
  network       = google_compute_network.deny_test_network.self_link
  priority      = 900
  deny          = [{ protocol = "all" }]
  source_ranges = ["0.0.0.0/0"]
  depends_on    = [google_compute_network.deny_test_network]
}
