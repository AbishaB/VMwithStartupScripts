 
module "vpc" {
  source     = "../../modules/net-vpc"
  project_id = var.project_id
  name       = var.vpc_name
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/24"
      name          = var.subnet_name
      region        = "europe-west1"
      secondary_ip_range = {
        pods     = "172.16.0.0/20"
        services = "192.168.0.0/24"
      }
    },
    {
      ip_cidr_range = "10.0.16.0/24"
      name          = "production"
      region        = "europe-west2"
      secondary_ip_range = {}
    }
  ]
}
# tftest modules=1 resources=3