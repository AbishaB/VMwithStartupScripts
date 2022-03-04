terraform {
  backend "gcs" {
    bucket = "linen-adapter-342115-backend"
    prefix = "vm-with-script-vpc"
  }
}