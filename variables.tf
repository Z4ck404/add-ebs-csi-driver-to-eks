variable "aws_region" {
  type = string
}
variable "aws_profile" {
  type    = string
  default = ""
}

variable "eks_cluster_name" {
  type = string
}

variable "install_vpc_cni_addon" {
  type    = bool
  default = false
}

variable "aws_kms_key_arn" {
  type    = string
  default = ""
}