provider "google" {}
provider "google-beta" {}

module "test" {
  source   = "../"
  location = "europe-north1"
}
