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

resource "google_compute_network" "egress_test_network" {
  project = var.project_id
  name    = "egress-test-network"
}
module "deny_egress_to_google_dns" {
  source             = "../../"
  project_id         = var.project_id
  name               = "deny-egress-to-google-dns"
  network            = google_compute_network.egress_test_network.self_link
  direction          = "EGRESS"
  deny               = [{ protocol = "udp", ports = ["53"] }]
  destination_ranges = ["8.8.8.8/32"]
  depends_on         = [google_compute_network.egress_test_network]
}
