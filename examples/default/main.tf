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