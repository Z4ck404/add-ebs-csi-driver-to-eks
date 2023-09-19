## add-ebs-csi-driver-to-eks

Create the IAM resources for the EBS CSI Driver and install the add-on on ab existing EKS cluster.

## Usage

```
module "eks-ebs-csi-driver" {
  source           = "Z4ck404/eks-ebs-csi-driver/aws"
  version          = "0.0.3"
  aws_profile      = "zack-aws-profile"
  aws_region       = "us-west-1"
  eks_cluster_name = "zack-eks"
}
```

## Examples:

You can find examples in `/examples`.
The example `/examples/default-with-k8s-resources` creates a pvc and a pod to test if the csi in installed and working properly.

## The module:
<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs_csi_irsa_role"></a> [ebs\_csi\_irsa\_role](#module\_ebs\_csi\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.17.0 |

### Resources

| Name | Type |
|------|------|
| [aws_eks_addon.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon_version.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | ## variables | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a | `string` | n/a | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->
