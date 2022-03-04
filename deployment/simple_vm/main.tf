provider "google" {
  project = "linen-adapter-342115"
  region  = "us-central1"
  zone    = "us-central1-c"
} 

data "google_compute_network" "my-network" {
  project = var.project_id
  name = var.vpc_name
}

data "google_compute_subnetwork" "my-subnetwork" {
  self_link = data.google_compute_network.my-network.subnetworks_self_links[0]
  project = var.project_id
}

module "simple-vm-example" {
  source     = "../../modules/compute-vm"
  project_id = var.project_id
  zone     = "europe-west1-b"
  name       = "test"
  network_interfaces = [{
    network    = data.google_compute_network.my-network.self_link
    subnetwork = data.google_compute_subnetwork.my-subnetwork.self_link
    nat        = false
    addresses  = null
  }]
  service_account_create = true
  meta_script = file("${path.module}/hello.sh")
}
# tftest modules=1 resources=2