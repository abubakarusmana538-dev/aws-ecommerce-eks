variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  description = "Private subnet for the app server"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "s3_bucket_arn" {
  description = "Bucket the app server may read and write"
  type        = string
}
