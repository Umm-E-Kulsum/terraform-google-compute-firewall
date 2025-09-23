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

package service_account_example

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestServiceAccountExample(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t, tft.WithTFDir("../../../examples/service_account_example"))

	bpt.DefineVerify(func(assert *assert.Assertions) {
		projectID := bpt.GetStringOutput("project_id")
		firewallName := bpt.GetStringOutput("name")
		saEmail := bpt.GetStringOutput("sa_email")

		op := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe %s --project %s --format json", firewallName, projectID))

		// Assert that the targetServiceAccounts field is set correctly
		assert.Equal(saEmail, op.Get("targetServiceAccounts.0").String(), "The firewall should target the correct service account")
	})

	bpt.Test()
}
