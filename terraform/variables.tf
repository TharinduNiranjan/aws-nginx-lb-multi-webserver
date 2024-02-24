variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "availability_zones" {
  type = list(any)
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}