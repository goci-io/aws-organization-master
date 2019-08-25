terraform {
  required_version = ">= 0.12.1"
  backend "s3" {}
}

provider "aws" {
  version = "~> 2.25"
}

locals {
  attachment_required = length(var.allow_assume_for_users) > 0 || length(var.allow_assume_for_roles) > 0  || length(var.allow_assume_for_groups) > 0 
}

resource "aws_organizations_organization" "default" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "default" {
  depends_on                 = ["aws_organizations_organization.default"]
  count                      = length(var.stages)
  name                       = lookup(var.stages[count.index], "name")
  email                      = lookup(var.stages[count.index], "email")
  iam_user_access_to_billing = lookup(var.stages[count.index], "billing_access", false) ? "ALLOW" : "DENY"
  role_name                  = var.organization_access_role_name
  tags                       = {
    Namespace = var.namespace
    Stage     = lookup(var.stages[count.index], "name")
  }
}

resource "null_resource" "role" {
  count      = local.attachment_required ? length(var.stages) : 0
  depends_on = ["aws_organizations_account.default"]
  triggers   = {
    role = format("arn:aws:iam::%s:role/%s", element(aws_organizations_account.default.*.id, count.index), var.organization_access_role_name)
  }
}

data "aws_iam_policy_document" "assume" {
  count = local.attachment_required ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = null_resource.role.*.triggers.role
  }
}

resource "aws_iam_policy" "assume_organization_role" {
  count       = local.attachment_required ? 1 : 0
  name        = format("%s-assume-organization-role", var.namespace)
  description = format("Allows to assume the %s in member accounts of the Organization", var.organization_access_role_name)
  policy      = element(data.aws_iam_policy_document.assume.*.json, 0)
  path        = "/"
}

resource "aws_iam_policy_attachment" "attach" {
  count      = local.attachment_required ? 1 : 0
  name       = format("%s-assume-organization-role", var.namespace)
  users      = var.allow_assume_for_users
  roles      = var.allow_assume_for_roles
  groups     = var.allow_assume_for_groups
  policy_arn = element(aws_iam_policy.assume_organization_role.*.arn, 0)
}