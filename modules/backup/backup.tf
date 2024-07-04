#TODO seperate environment vaults in replicated region?

resource "aws_backup_vault" "env_vault" {
  name = "env_vault"
}

resource "aws_backup_vault" "env_replicated_vault" {
  count    = var.backup_replication_enabled ? 1 : 0
  name     = "env_replicated_vault"
  provider = aws.backup-region
}

resource "aws_backup_plan" "daily_backup_plan" {
  name = "daily_environment_backup_plan"
  rule {
    rule_name         = "once_daily_backup"
    target_vault_name = aws_backup_vault.env_vault.name
    schedule          = var.daily_backup_schedule
    dynamic "copy_action" {
      for_each = var.backup_replication_enabled ? [1] : []
      content {
        destination_vault_arn = aws_backup_vault.env_replicated_vault[0].arn
        lifecycle {
          delete_after = 1 #Days
        }
      }
    }
    lifecycle {
      #TODO: think about cold storage for prod
      delete_after = 1 #Days
    }
  }
}

resource "aws_backup_selection" "daily_backup_selection" {
  name         = "daily_backup_selection"
  iam_role_arn = aws_iam_role.aws_backup_role.arn
  plan_id      = aws_backup_plan.daily_backup_plan.id
  resources = [
    "arn:aws:s3:::ultimo010"
  ]
}
