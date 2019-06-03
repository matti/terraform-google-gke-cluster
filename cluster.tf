resource "random_uuid" "google_container_cluster" {}

resource "google_container_cluster" "default" {
  provider = "google-beta"

  network  = var.network
  location = var.location

  name = var.name == null ? "gke-${random_uuid.google_container_cluster.result}" : var.name

  min_master_version = var.minimum_version

  initial_node_count       = 1
  remove_default_node_pool = true

  master_auth {
    username = ""
    password = ""

    # https://github.com/terraform-providers/terraform-provider-google/issues/3369#issuecomment-497819347

    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }

  dynamic "private_cluster_config" {
    for_each = var.private_nodes == true ? list(var.master_ipv4_cidr_block) : []

    content {
      enable_private_nodes   = true
      master_ipv4_cidr_block = private_cluster_config.value
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "all"
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  ip_allocation_policy {
    create_subnetwork = true
    // Prior to June 17th 2019, the default on the API is false; afterwards, it's true.
    use_ip_aliases = true
  }

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }
}
