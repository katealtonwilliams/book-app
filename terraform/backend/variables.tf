variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "state_bucket" {
  type    = string
  default = "terraform_state_c76b7076-4949-4ddc-830f-bb61d5fb43fe"
}

variable "state_table" {
  type    = string
  default = "terraform_state_lock"
}
