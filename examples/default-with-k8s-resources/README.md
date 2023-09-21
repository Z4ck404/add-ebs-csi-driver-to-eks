### What this example does:
- [x] Create the IAM resources and install/configure the add-on
- [x] Creates a PVC with the default storage class and create a pod that use it.
<!-- BEGIN_TF_DOCS -->
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_add-ebs-csi-driver"></a> [add-ebs-csi-driver](#module\_add-ebs-csi-driver) | ../.. | n/a |

### Resources

| Name | Type |
|------|------|
| [kubernetes_persistent_volume.pv-test-ebs-csi](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume) | resource |
| [kubernetes_pod.pod-with-pvc](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod) | resource |

### Inputs

No inputs.

### Outputs

No outputs.
<!-- END_TF_DOCS -->