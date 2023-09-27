## add-ebs-csi-driver-to-eks

Create the IAM resources for the EBS CSI Driver and install the add-on on an existing EKS cluster.

## Usage

- version `0.0.x`
  ```diff
  module "eks-ebs-csi-driver" {
    source           = "Z4ck404/eks-ebs-csi-driver/aws"
    version          = "0.0.6"

    aws_profile      = "zack-aws-profile"
    aws_region       = "us-west-1"
    eks_cluster_name = "zack-eks"
  }
  ```

- version `0.1.x`
  ```diff
  module "eks-ebs-csi-driver" {
    source           = "Z4ck404/eks-ebs-csi-driver/aws"
    version          = "0.1.0"

    aws_profile      = "zack-aws-profile"
    aws_region       = "us-west-1"
    eks_cluster_name = "zack-eks"

  + install_vpc_cni_addon = true
  }
  ```
  The module will also install the `aws_vpc_cni` add on if the variables `install_vpc_cni_addon` is set to `true` (defaults to `false`).

## Examples:

You can find examples in `/examples`.
The example `/examples/default-with-k8s-resources` creates a pvc and a pod to test if the csi in installed and working properly.

## Troubleshooting:
1.
```
Q: I applied the terraform, everything seems to be created and installed correctly but the `csi driver` still throws an *unauthorized* error, why ?

A: It could be because of an explicit deny tp create EBS volumes in a CSP policy, make sure to check that.

```
2.
```
Q: I applied the terraform, everything seems to be created and installed correctly but driver fails to provision the volume and throws an error of type `Parameters on this idempotent request are inconsistent with parameters used in previous request(s)`

A: It could be because you enabled automatic automatic encryption of EBS volumes with a specific KMS key that the IAM role the terraform created for the driver doesn't have access to. Make sure to allow the role to use the KMS key used to encrypt EBS volumes. Support for that will be added to this module in the future.
```

## The module:
<!-- BEGIN_TF_DOCS -->
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs_csi_irsa_role"></a> [ebs\_csi\_irsa\_role](#module\_ebs\_csi\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.17.0 |
| <a name="module_vpc_cni_ipv4_irsa_role"></a> [vpc\_cni\_ipv4\_irsa\_role](#module\_vpc\_cni\_ipv4\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.17.0 |

### Resources

| Name | Type |
|------|------|
| [aws_eks_addon.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon_version.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_addon_version.vpc-cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | n/a | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_install_vpc_cni_addon"></a> [install\_vpc\_cni\_addon](#input\_install\_vpc\_cni\_addon) | n/a | `bool` | `false` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->
