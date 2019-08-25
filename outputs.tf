output "organization_id" {
  value = "${aws_organizations_organization.default.id}"
}

output "organization_arn" {
  value = "${aws_organizations_organization.default.arn}"
}

output "organization_master_account_id" {
  value = "${aws_organizations_organization.default.master_account_id}"
}

output "organization_master_account_arn" {
  value = "${aws_organizations_organization.default.master_account_arn}"
}

output "organization_master_account_email" {
  value = "${aws_organizations_organization.default.master_account_email}"
}

output "organization_account_arns" {
  value = aws_organizations_account.default.*.arn
}

output "organization_account_ids" {
  value = aws_organizations_account.default.*.id
}
