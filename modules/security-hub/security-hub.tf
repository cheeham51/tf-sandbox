resource "aws_securityhub_account" "account_enablement" {
  count = data.aws_region.current.name != "ap-southeast-2" ? 1 : 0
}

resource "aws_securityhub_organization_admin_account" "admin_account" {
  count            = var.is_admin_account ? 1 : 0
  admin_account_id = var.admin_account_id
}

resource "aws_securityhub_standards_subscription" "nist_800_53" {
  count         = var.is_admin_account ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/nist-800-53/v/5.0.0"
  depends_on    = [aws_securityhub_organization_admin_account.admin_account[0]]
}

resource "aws_securityhub_organization_configuration" "org_config" {
  count       = var.is_admin_account ? 1 : 0
  auto_enable = true
  depends_on    = [aws_securityhub_organization_admin_account.admin_account[0]]
}

resource "aws_securityhub_finding_aggregator" "finding_aggregator" {
  count        = var.is_admin_account ? 1 : 0
  linking_mode = "ALL_REGIONS"
  # depends_on   = [aws_securityhub_account.account_enablement]
}

# resource "aws_securityhub_member" "org_member" {
#   count = (!var.is_admin_account && data.aws_region.current.name == "ap-southeast-2") ? 1 : 0
#   account_id = data.aws_caller_identity.current.account_id
# }