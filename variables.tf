
variable "stages" {
  description = "List of account names to create in this organization"
  type = list(object({
    name           = string
    email          = string
    billing_access = bool
  }))
}

variable "organization_access_role_name" {
  type        = string
  default     = "OrganizationAccountAccessRole"
  description = "The name for the access role in member accounts of this organization"
}

variable "namespace" {
  type        = string
  description = "The company or organizations identifier"
}

variable "allow_assume_for_groups" {
  type        = list(string)
  default     = []
  description = "Groups which will be allowed to assume the organization access role"
}

variable "allow_assume_for_users" {
  type        = list(string)
  default     = []
  description = "Usernames which will be allowed to assume the organization access role"
}

variable "allow_assume_for_roles" {
  type        = list(string)
  default     = []
  description = "Role names which will be allowed to assume the organization access role"
}
