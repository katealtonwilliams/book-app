#see if can add region variable
variable "state_bucket" {
  type    = string
  default = "terraform-state-c76b7076-4949-4ddc-830f-bb61d5fb43fe"
}

variable "state_table" {
  type    = string
  default = "terraform_state_lock"
}
