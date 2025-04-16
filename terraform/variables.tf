variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "state_lock_table" {
    type    = string
    default = "terraform-state-lock"
}