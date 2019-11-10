resource "random_uuid" "google_container_cluster" {}

resource "google_container_cluster" "default" {
  provider = "google-beta"

  name = var.name == null ? random_uuid.google_container_cluster.result : var.name

  location = var.location

  // zone
  // region
  // node_locations
  // additional_zones

  // addons_config {
  //   horizontal_pod_autoscaling
  //   http_load_balancing
  //   kubernetes_dashboard
  //   network_policy_config
  //   istio_config {
  //     disabled
  //     auth
  //   }
  //   cloudrun_config
  // }

  // cluster_ipv4_cidr
  // cluster_autoscaling {
  //   enabled
  //   resource_limits {
  //     resource_type
  //     minimum
  //     maximum
  //   }
  // }
  // database_encryption {
  //   state
  //   key_name
  // }
  // description
  // default_max_pods_per_node
  // enable_binary_authorization
  // enable_kubernetes_alpha
  // enable_tpu
  // enable_legacy_abac
  // enable_shielded_nodes

  initial_node_count = 1

  ip_allocation_policy {
    //   use_ip_aliases
    //   cluster_secondary_range_name
    //   services_secondary_range_name
    //   cluster_ipv4_cidr_block
    //   node_ipv4_cidr_block
    //   services_ipv4_cidr_block
    //   create_subnetwork
    //   subnetwork_name
  }

  // logging_service

  maintenance_policy {
    daily_maintenance_window {
      start_time = "01:00"
      // recurring_winidow
    }
  }

  master_auth {
    password = ""
    username = ""

    // client_certificate_config {
    //   issue_client_certificate
    // }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "all"
    }
  }


  // min_master_version
  // monitoring_service

  network = var.network

  // network_policy {
  //   provider
  //   enabled
  // }

  // node_config {
  //   WORST_PRACTISE
  // }
  // node_pool
  // node_version
  // pod_security_policy_config {
  //   enabled
  // }

  // authenticator_groups_config {
  //   security_group
  // }

  dynamic "private_cluster_config" {
    for_each = var.private_nodes == true ? list(var.master_ipv4_cidr_block) : []

    content {
      // enable_private_endpoint
      enable_private_nodes   = true
      master_ipv4_cidr_block = private_cluster_config.value
    }
  }

  // project

  release_channel {
    channel = "STABLE"
  }

  remove_default_node_pool = true

  // resource_labels
  // resource_usage_export_config {
  //   enable_network_egress_metering
  //   bigquery_destination
  //   bigquery_destination.dataset_id
  // }
  // subnetwork
  // vertical_pod_autoscaling
  // workload_identity_config {
  //  identity_namespace
  // }
  // enable_intranode_visibility
}
