vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_cidrs       = ["10.0.1.0/24"]
private_cidrs      = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
ami_id             = "ami-0c7217cdde317cfec"
instance_type      = "t2.micro"
