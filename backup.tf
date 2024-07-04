# module "datastore_backup" {
#   source = "./modules/backup"
#   providers = {
#     aws               = aws
#     aws.backup-region = aws.backup-region
#   }
#   backup_replication_enabled = true
# }