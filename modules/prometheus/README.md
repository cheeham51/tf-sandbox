<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.infra"></a> [aws.infra](#provider\_aws.infra) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_grafana_apikey_rotation_handler"></a> [grafana\_apikey\_rotation\_handler](#module\_grafana\_apikey\_rotation\_handler) | git::git@bitbucket.org:ff_infrastructure/terraform-modules.git//modules/lambda-zip | 1.56 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_grafana_role_association.admin_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_role_association) | resource |
| [aws_grafana_role_association.editor_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_role_association) | resource |
| [aws_grafana_role_association.viewer_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_role_association) | resource |
| [aws_grafana_workspace.workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace) | resource |
| [aws_grafana_workspace_api_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/grafana_workspace_api_key) | resource |
| [aws_iam_policy.api_key_rotation_lambda_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.api_key_rotation_lambda_execution_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.xray](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_permission.secrets_manager_api_key_rotation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_prometheus_workspace.workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/prometheus_workspace) | resource |
| [aws_route53_record.grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_object.rotation_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_secretsmanager_secret.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_rotation.api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_secretsmanager_secret_version.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.grafana_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [archive_file.zip_rotation_handler](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.api_key_rotation_lambda_execution_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key_rotation_days"></a> [api\_key\_rotation\_days](#input\_api\_key\_rotation\_days) | n/a | `number` | `29` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | The Route53 Zone ID | `string` | n/a | yes |
| <a name="input_source_bucket_name"></a> [source\_bucket\_name](#input\_source\_bucket\_name) | The bucket to pull the zip from | `string` | n/a | yes |
| <a name="input_sso_admin_group_id"></a> [sso\_admin\_group\_id](#input\_sso\_admin\_group\_id) | SSO Admin Group ID | `string` | `"97671efe89-79d99e10-1616-4116-8ef1-3ef2907a6d86"` | no |
| <a name="input_sso_developer_group_id"></a> [sso\_developer\_group\_id](#input\_sso\_developer\_group\_id) | SSO Developer Group ID | `string` | `"97671efe89-b8fd537a-799b-418c-856d-8655e5736ac4"` | no |
| <a name="input_sso_org_unit"></a> [sso\_org\_unit](#input\_sso\_org\_unit) | SSO Org Unit | `string` | `"ou-gjg6-wo00esyv"` | no |
| <a name="input_sso_quality_group_id"></a> [sso\_quality\_group\_id](#input\_sso\_quality\_group\_id) | SSO Quality Group ID | `string` | `"97671efe89-5b179c7d-ffa5-4be8-9d4f-c853ff565b54"` | no |
| <a name="input_sso_readonly_group_id"></a> [sso\_readonly\_group\_id](#input\_sso\_readonly\_group\_id) | SSO ReadOnly Group ID | `string` | `"97671efe89-7c77bf4d-7d2c-487d-81c5-2d78ff71acdf"` | no |
| <a name="input_sso_support_group_id"></a> [sso\_support\_group\_id](#input\_sso\_support\_group\_id) | SSO Support Group ID | `string` | `"97671efe89-8256da3c-87fc-485d-bb8f-c554a2eef4c8"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |
| <a name="input_vpc_private_subnets"></a> [vpc\_private\_subnets](#input\_vpc\_private\_subnets) | The private subnets for the VPC | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_alias"></a> [workspace\_alias](#output\_workspace\_alias) | n/a |
| <a name="output_workspace_api_key_name"></a> [workspace\_api\_key\_name](#output\_workspace\_api\_key\_name) | n/a |
| <a name="output_workspace_arn"></a> [workspace\_arn](#output\_workspace\_arn) | n/a |
<!-- END_TF_DOCS -->