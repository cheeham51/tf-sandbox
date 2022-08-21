package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

// An example of how to test the Terraform module in examples/terraform-aws-lambda-example using Terratest.
func TestTerraformEcsSchedulerLambda(t *testing.T) {
	t.Parallel()

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Variables to pass to our Terraform code using -var options
		EnvVars: map[string]string{
			"AWS_PROFILE": "home",
			"AWS_DEFAULT_REGION": "us-east-1",
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

}
