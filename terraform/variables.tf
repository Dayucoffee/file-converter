variable "key_name" {
  default = null
  description = "Optional: Name of the key pair to use for instances"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "region" {
  default = "us-east-1"
}
