variable "zone_name" {
  type        = string
  default     = "sainathdevops.space"
  description = "description"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy resources"
}

variable "bucket_name" {
  type        = string
  default     = "state-tf-projects"
  description = "S3 bucket name for state file"
}
variable "table_name" {
  type        = string
  default     = "terraform-state-locks"
  description = "DynamoDB table name for state locking"
}