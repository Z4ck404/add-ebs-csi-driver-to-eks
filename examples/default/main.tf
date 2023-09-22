provider "aws" {
  region  = "us-west-1"
  profile = "bigdata-labs"
}

module "add-ebs-csi-driver" {
  source = "../.."

  aws_profile      = "bigdata-labs"
  aws_region       = "us-west-1"
  eks_cluster_name = "telemetry-zack"
}