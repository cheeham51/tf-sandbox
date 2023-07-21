data "aws_secretsmanager_secret_version" "ever_blue_zone_workspace_password" {
  secret_id = "ever_blue_zone_workspace_password"
}

data "aws_workspaces_bundle" "ubuntu" {
  owner = "AMAZON"
  name  = "Standard with Ubuntu 22.04"
}

resource "aws_workspaces_directory" "ever_blue_zone_workspace_directory" {
  directory_id = aws_directory_service_directory.ever_blue_zone_simple_directory.id
  subnet_ids = [
    "subnet-19062670",
    "subnet-18062671"
  ]

  self_service_permissions {
    change_compute_type  = true
    increase_volume_size = true
    rebuild_workspace    = true
    restart_workspace    = true
    switch_running_mode  = true
  }

  workspace_access_properties {
    device_type_android    = "DENY"
    device_type_chromeos   = "DENY"
    device_type_ios        = "DENY"
    device_type_linux      = "DENY"
    device_type_osx        = "ALLOW"
    device_type_web        = "DENY"
    device_type_windows    = "DENY"
    device_type_zeroclient = "DENY"
  }

  workspace_creation_properties {
    enable_internet_access              = true
    enable_maintenance_mode             = true
    user_enabled_as_local_administrator = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access
  ]
}

resource "aws_directory_service_directory" "ever_blue_zone_simple_directory" {
  name     = "corp.everbluezone.com"
  password = data.aws_secretsmanager_secret_version.ever_blue_zone_workspace_password.secret_string
  size     = "Small"
  type     = "SimpleAD"

  vpc_settings {
    vpc_id = "vpc-0606266f"
    subnet_ids = [
      "subnet-19062670",
      "subnet-18062671"
    ]
  }
}

data "aws_iam_policy_document" "workspaces" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["workspaces.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "workspaces_default" {
  name               = "workspaces_DefaultRole"
  assume_role_policy = data.aws_iam_policy_document.workspaces.json
}

resource "aws_iam_role_policy_attachment" "workspaces_default_service_access" {
  role       = aws_iam_role.workspaces_default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess"
}

resource "aws_iam_role_policy_attachment" "workspaces_default_self_service_access" {
  role       = aws_iam_role.workspaces_default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesSelfServiceAccess"
}

resource "aws_workspaces_workspace" "ever_blue_zone_workspace" {
  directory_id = aws_workspaces_directory.ever_blue_zone_workspace_directory.id
  bundle_id    = data.aws_workspaces_bundle.ubuntu.id
  user_name    = "ebz"

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = "arn:aws:kms:ap-southeast-2:516161102907:key/abf11012-a635-45a9-9bbb-71af8116d6ff"

  workspace_properties {
    compute_type_name                         = "STANDARD"
    user_volume_size_gib                      = 50
    root_volume_size_gib                      = 80
    running_mode                              = "AUTO_STOP"
    running_mode_auto_stop_timeout_in_minutes = 60
  }
}