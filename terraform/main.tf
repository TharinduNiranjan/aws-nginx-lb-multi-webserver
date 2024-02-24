module "networking" {
  source             = "./modules/networking"
  vpc_cidr           = var.vpc_cidr
  public_cidrs       = var.public_cidrs
  private_cidrs      = var.private_cidrs
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.networking.vpc_id
}

module "compute_instances" {
  source                 = "./modules/compute_instances"
  public_security_group  = module.security_groups.public_security_group
  private_security_group = module.security_groups.private_security_group
  private_subnet         = module.networking.private_subnet
  public_subnet          = module.networking.public_subnet
  instance_type          = var.instance_type
  ami_id                 = var.ami_id
}

