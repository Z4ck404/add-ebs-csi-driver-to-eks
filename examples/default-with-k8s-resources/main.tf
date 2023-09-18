provider "aws" {
  region  = "us-west-1"
  profile = "zack-aws-profile"
}

module "add-ebs-csi-driver" {
  source = "../.."

  aws_profile      = "zack-aws-profile"
  aws_region       = "us-west-1"
  eks_cluster_name = "zack-eks"
}

## k8s resources for testing:
provider "kubernetes" {
}

resource "kubernetes_persistent_volume" "pv-test-ebs-csi" {
  metadata {
    name = "pv-test-ebs-csi"
  }
  spec {
    capacity {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]

  }
}

resource "kubernetes_pod" "pod-with-pvc" {
  metadata {
    name = "pod-with-pvc"
  }

  spec {
    volume {
      name = "pv-test-ebs-csi"
      persistent_volume_claim {
        claim_name = "pv-test-ebs-csi"
      }
    }
    container {
      name  = "with-pvc"
      image = nginx
      port {
        container_port = "80"
        name = "http-server"
      }
      volume_mount {
        name = "pv-test-ebs-csi"
        mount_path = "/usr/share/nginx/html"
      }
    }
  }
  depends_on = [ kubernetes_persistent_volume.pv-test-ebs-csi ]
}

