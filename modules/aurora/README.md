<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_rds_cluster.aurora_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.aurora_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_group_ids"></a> [additional\_security\_group\_ids](#input\_additional\_security\_group\_ids) | A list of additional security group IDs to attach to the Aurora cluster | `list(string)` | `[]` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Allocated storage | `number` | `20` | no |
| <a name="input_auto_pause"></a> [auto\_pause](#input\_auto\_pause) | Whether or not to auto-pause the Aurora database | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The list of Availability Zones (AZs) where instances in the cluster can be created. | `list(string)` | <pre>[<br>  "ap-southeast-2a",<br>  "ap-southeast-2b",<br>  "ap-southeast-2c"<br>]</pre> | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The number of days to retain automated backups. | `number` | `30` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | The unique name for the database cluster. | `string` | `"frankie-rds-cluster"` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether or not to create a new security group for the Aurora cluster | `bool` | `false` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the Aurora database | `string` | n/a | yes |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of the DB subnet group for the Aurora database | `string` | n/a | yes |
| <a name="input_dsn"></a> [dsn](#input\_dsn) | The data source name for the Aurora database | `string` | `"dsn"` | no |
| <a name="input_dsn_regex"></a> [dsn\_regex](#input\_dsn\_regex) | The regex to use to extract the secret from dsn string | `string` | `".*:(.*)@.*"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine mode. | `string` | `"aurora-postgresql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the Aurora database engine | `string` | `"15.2"` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment to deploy the Aurora cluster in | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | DB Instance Class | `string` | `"db.t3.small"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of instances to create in the cluster. | `number` | `1` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Define when to perform maintenance in UTC format: ddd:hh24:mi-ddd:hh24:mi - default is 1am Thursday AEST | `string` | `"Thu:15:00-Thu:15:30"` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Aurora cluster master\_password | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | The name of the master user for the cluster. | `string` | n/a | yes |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | The maximum capacity of the Aurora database | `number` | `8` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | The minimum capacity of the Aurora database | `number` | `1` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval for CloudWatch monitoring of the Aurora database | `number` | `10` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Whether or not to deploy the Aurora database in a multi-AZ configuration | `bool` | `true` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Whether or not to enable performance insights for the Aurora database | `bool` | `false` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | The daily time range during which automated backups are created. | `string` | `"07:00-09:00"` | no |
| <a name="input_seconds_until_auto_pause"></a> [seconds\_until\_auto\_pause](#input\_seconds\_until\_auto\_pause) | The number of seconds until the Aurora database is auto-paused | `number` | `300` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name of the security group for the Aurora cluster | `string` | n/a | yes |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Whether or not to encrypt the Aurora database | `bool` | `false` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The storage type for the Aurora database | `string` | `"gp2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "terraform": "aws-infra-core2"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to deploy the Aurora cluster in | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | The ID of the security group to associate with the cluster. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_cluster_endpoint"></a> [aurora\_cluster\_endpoint](#output\_aurora\_cluster\_endpoint) | n/a |
| <a name="output_aurora_cluster_master_password"></a> [aurora\_cluster\_master\_password](#output\_aurora\_cluster\_master\_password) | n/a |
| <a name="output_aurora_cluster_master_username"></a> [aurora\_cluster\_master\_username](#output\_aurora\_cluster\_master\_username) | n/a |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | n/a |
<!-- END_TF_DOCS -->