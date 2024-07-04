<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.sso"></a> [aws.sso](#provider\_aws.sso) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_securityhub_account.account_enablement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_organization_admin_account.admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_admin_account) | resource |
| [aws_securityhub_standards_subscription.nist_800_53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_account_id"></a> [admin\_account\_id](#input\_admin\_account\_id) | The AWS account ID of the Security Hub administrator account | `string` | `""` | no |
| <a name="input_is_admin_account"></a> [is\_admin\_account](#input\_is\_admin\_account) | Indicates if this account is the Security Hub administrator account | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->