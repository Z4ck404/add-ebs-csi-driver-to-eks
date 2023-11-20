### IAM roles for the add-ons
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

module "vpc_cni_ipv4_irsa_role" {
  count = var.install_vpc_cni_addon ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.17.0"

  role_name             = "VPC_CNI_Addon_ROLE"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    ex = {
      provider_arn               = data.aws_iam_openid_connect_provider.this.arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

}

### EKS Add-ons
resource "aws_eks_addon" "ebs_csi" {
  cluster_name      = data.aws_eks_cluster.this.id
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = data.aws_eks_addon_version.ebs_csi.version
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
}
resource "aws_eks_addon" "vpc-cni" {
  count             = var.install_vpc_cni_addon ? 1 : 0
  cluster_name      = data.aws_eks_cluster.this.id
  addon_name        = "vpc-cni"
  addon_version     = data.aws_eks_addon_version.vpc-cni.version
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = module.vpc_cni_ipv4_irsa_role[0].iam_role_arn
}

### KMS key policy, when EBS encryption is enabled
data "aws_iam_policy_document" "kms_use" {
  count = var.aws_kms_key_arn != "" ? 1 : 0
  statement {
    sid    = "allow-kms-key-use"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "${var.aws_kms_key_arn}"
    ]
  }
}

resource "aws_iam_policy" "kms_use" {
  count       = var.aws_kms_key_arn != "" ? 1 : 0
  name        = "kms-key-use"
  description = "Policy to allow use of KMS Key"
  policy      = data.aws_iam_policy_document.kms_use[0].json
}

resource "aws_iam_role_policy_attachment" "role-kms-use-policy" {
  count      = var.aws_kms_key_arn != "" ? 1 : 0
  role       = module.ebs_csi_irsa_role.name
  policy_arn = aws_iam_policy.kms_use[0].arn
}