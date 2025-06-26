variable "aws_region" {
  description = "AWS region to deploy in"
  default     = "us-east-1"
}

variable "key_name" {
  description = "AWS key pair name for SSH access"
  type        = string
}
