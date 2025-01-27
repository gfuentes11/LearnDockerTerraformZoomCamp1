variable "credentials" {
    description = "My GCP Creds"
    default = "/home/gfuentesZoomCamp/LearnDockerTerraformZoomCamp1/gcpKeys/zoomCamp_env.json"
}
variable "project" {
  description = "Project Name"
  default     = "zoomcamp1-terraform"
}

variable "region" {
  description = "Region Name"
  default     = "us-east4-a"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My Big Query Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "zoomcamp1-terraform-bucket"
}

variable "gcs_stoarge_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}