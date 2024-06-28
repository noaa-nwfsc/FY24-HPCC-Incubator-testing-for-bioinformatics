/**
  * Copyright 2023 Google LLC
  *
  * Licensed under the Apache License, Version 2.0 (the "License");
  * you may not use this file except in compliance with the License.
  * You may obtain a copy of the License at
  *
  *      http://www.apache.org/licenses/LICENSE-2.0
  *
  * Unless required by applicable law or agreed to in writing, software
  * distributed under the License is distributed on an "AS IS" BASIS,
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  */

module "network1" {
  source          = "./modules/embedded/modules/network/vpc"
  deployment_name = var.deployment_name
  project_id      = var.project_id
  region          = var.region
}

module "slurm_compute_bucket" {
  source          = "./modules/embedded/community/modules/file-system/cloud-storage-bucket"
  deployment_name = var.deployment_name
  labels          = var.labels
  local_mount     = "/data"
  project_id      = var.project_id
  region          = var.region
}

module "mount-at-startup" {
  source          = "./modules/embedded/modules/scripts/startup-script"
  deployment_name = var.deployment_name
  labels          = var.labels
  project_id      = var.project_id
  region          = var.region
  runners         = [module.slurm_compute_bucket.client_install_runner, module.slurm_compute_bucket.mount_runner]
}

module "homefs" {
  source          = "./modules/embedded/modules/file-system/filestore"
  deployment_name = var.deployment_name
  labels          = var.labels
  local_mount     = "/home"
  network_id      = module.network1.network_id
  project_id      = var.project_id
  region          = var.region
  zone            = var.zone
}

module "debug_node_group" {
  source                 = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v5-node-group"
  labels                 = var.labels
  machine_type           = "n2-standard-2"
  node_count_dynamic_max = 4
  project_id             = var.project_id
}

module "debug_partition" {
  source               = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v5-partition"
  deployment_name      = var.deployment_name
  enable_placement     = false
  exclusive            = false
  is_default           = true
  network_storage      = flatten([module.homefs.network_storage])
  node_groups          = flatten([module.debug_node_group.node_groups])
  partition_name       = "debug"
  project_id           = var.project_id
  region               = var.region
  subnetwork_self_link = module.network1.subnetwork_self_link
  zone                 = var.zone
}

module "compute_node_group" {
  source                 = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v5-node-group"
  bandwidth_tier         = "gvnic_enabled"
  labels                 = var.labels
  node_count_dynamic_max = 20
  project_id             = var.project_id
}

module "compute_partition" {
  source               = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v5-partition"
  deployment_name      = var.deployment_name
  enable_placement     = false
  enable_reconfigure   = true
  exclusive            = false
  network_storage      = flatten([module.slurm_compute_bucket.network_storage, flatten([module.homefs.network_storage])])
  node_groups          = flatten([module.compute_node_group.node_groups])
  partition_name       = "compute"
  project_id           = var.project_id
  region               = var.region
  subnetwork_self_link = module.network1.subnetwork_self_link
  zone                 = var.zone
}

module "h3_node_group" {
  source                 = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v5-node-group"
  bandwidth_tier         = "gvnic_enabled"
  disk_type              = "pd-balanced"
  labels                 = var.labels
  machine_type           = "c2-standard-8"
  node_count_dynamic_max = 20
  project_id             = var.project_id
}

module "h3_partition" {
  source               = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v5-partition"
  deployment_name      = var.deployment_name
  network_storage      = flatten([module.homefs.network_storage])
  node_groups          = flatten([module.h3_node_group.node_groups])
  partition_name       = "h3"
  project_id           = var.project_id
  region               = var.region
  subnetwork_self_link = module.network1.subnetwork_self_link
  zone                 = var.zone
}

module "slurm_controller" {
  source                        = "./modules/embedded/community/modules/scheduler/schedmd-slurm-gcp-v5-controller"
  deployment_name               = var.deployment_name
  disable_controller_public_ips = false
  labels                        = var.labels
  network_self_link             = module.network1.network_self_link
  network_storage               = flatten([module.homefs.network_storage])
  partition                     = flatten([module.h3_partition.partition, flatten([module.compute_partition.partition, flatten([module.debug_partition.partition])])])
  project_id                    = var.project_id
  region                        = var.region
  subnetwork_self_link          = module.network1.subnetwork_self_link
  zone                          = var.zone
}

module "slurm_login" {
  source                   = "./modules/embedded/community/modules/scheduler/schedmd-slurm-gcp-v5-login"
  controller_instance_id   = module.slurm_controller.controller_instance_id
  deployment_name          = var.deployment_name
  disable_login_public_ips = false
  labels                   = var.labels
  machine_type             = "n2-standard-4"
  network_self_link        = module.network1.network_self_link
  project_id               = var.project_id
  pubsub_topic             = module.slurm_controller.pubsub_topic
  region                   = var.region
  subnetwork_self_link     = module.network1.subnetwork_self_link
  zone                     = var.zone
}
