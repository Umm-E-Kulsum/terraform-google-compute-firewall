// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


package simple_example

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSimpleExample(t *testing.T) {
	// Initialize the blueprint test object, pointing to the simple_example directory
	bpt := tft.NewTFBlueprintTest(t, tft.WithTFDir("../../../examples/simple_example"))

	bpt.DefineVerify(func(assert *assert.Assertions) {
		// Get the project_id and firewall name from the outputs
		projectID := bpt.GetStringOutput("project_id")
		firewallName := bpt.GetStringOutput("name")

		// Verify the firewall name from the output matches the expected hardcoded name
		assert.Equal("example-allow-web-and-icmp", firewallName, "The output name should match the hardcoded name in the example")

		// Construct the gcloud command to describe the firewall rule
		cmd := fmt.Sprintf("compute firewall-rules describe %s --project %s --format json", firewallName, projectID)

		// Run the gcloud command and parse the JSON output
		op := gcloud.Run(t, cmd)

		// Assert that the firewall rule has the correct properties as defined in the example
		assert.Contains(op.Get("network").String(), "firewall-simple-example-net", "The firewall rule should be attached to the correct network")
		assert.Equal("INGRESS", op.Get("direction").String(), "The firewall rule direction should be INGRESS")

		// Verify the allow rules
		allowed := op.Get("allowed").Array()
		assert.Equal(2, len(allowed), "There should be two allow rules")
	})

	bpt.Test()
}
