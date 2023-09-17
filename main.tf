## backend
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

### variables
variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

## you can get this by :
#1- aws eks describe-cluster --name <cluster_name> --query "cluster.identity.oidc.issuer" --output text
#2- aws iam list-open-id-connect-providers --profile <> --region us-west-1| grep <the_id_from_1>
# variable "eks_oidc_provider_arn" {
#   type = string
# }

### data
data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}

data "aws_iam_openid_connect_provider" "this" {
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}

### IAM roles ebs csi driver

module "ebs_csi_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.17.0"

  role_name             = "EBS_CSI_Driver_ROLE"
  attach_ebs_csi_policy = true

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = data.aws_iam_openid_connect_provider.this.arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

data "aws_eks_addon_version" "ebs_csi" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = data.aws_eks_cluster.this.version
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name      = var.eks_cluster_name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = data.aws_eks_addon_version.ebs_csi.version
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
}