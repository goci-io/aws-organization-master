# aws-organization-master

**Maintained by [@goci-io/prp-terraform](https://github.com/orgs/goci-io/teams/prp-terraform)**

![terraform](https://github.com/goci-io/aws-organization-master/workflows/terraform/badge.svg?branch=master)

This module provisions an AWS Organization and corresponding member accounts. [Read more](https://aws.amazon.com/organizations/) about AWS Organizations in general. 
Additionally this module allows you to pass in role, user or group names to grant access to assume the organization role created in the member accounts. 

## Configuration

Please note hints about AWS organizations and how to delete them properly from [Terraform documentation](https://www.terraform.io/docs/providers/aws/r/organizations_account.html)

| Name | Description | Default |
|-------------------------------|------------------------------------------------------------------------------------------------|-------------------------------|
| stages | List of stages which represent member accounts. Object of `name`, `email` and `billing_access` | - |
| organization_access_role_name | Name of the role automatically created in the member accounts by AWS | OrganizationAccountAccessRole |
| namespace | The company or organization prefix (eg: goci) | - |
| allow_assume_for_groups | List of group names in the master account, allowed to assume the member role | `[]` |
| allow_assume_for_users | List of usernames in the master account, allowed to assume the member role | `[]` |
| allow_assume_for_roles | List of role names in the master account, allowed to assume the member role | `[]` |
| only_with_mfa | Enforces MFA for users, groups and roles. If false roles will be able to assume without MFA enabled | false |
| disable_mfa | Disables MFA for users, groups. Cannot be used in combination with only_with_mfa. We suggest to not disbale MFA for humans | false |

Look into the [terraform.tfvars](terraform.tfvars.example) example.
