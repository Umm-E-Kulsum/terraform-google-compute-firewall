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

resource "google_compute_network" "example_network" {
  project = var.project_id
  name    = "firewall-simple-example-net"
}

module "firewall_rule" {
  source = "../../"

  project_id = var.project_id
  name       = "example-allow-web-and-icmp"
  network    = google_compute_network.example_network.self_link

  description = "A firewall rule created by the simple_example."
  direction   = "INGRESS"
  priority    = 1000

  allow = [
    {
      protocol = "tcp"
      ports    = ["80", "443"]
    },
    {
      protocol = "icmp"
    }
  ]

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]

  depends_on = [google_compute_network.example_network]
}
