## add-ebs-csi-driver-to-eks

1- run `terraform init && terraform appy` to install the required resources

2- make sure it works by installing the resources in `/examples`:

    - `k apply -f examples/pvc.yaml -n kube-system`

    - `k apply -f examples/pod.yaml -n kube-system`