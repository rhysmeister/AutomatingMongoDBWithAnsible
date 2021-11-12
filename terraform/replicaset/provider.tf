provider "aws" {
  profile = "aws_terraform"
  region  = var.region

  default_tags {
    tags = {
      name    = "mongodb_replicaset"
      project = "AutomatingMongoDB" 
    }
  } 
}
