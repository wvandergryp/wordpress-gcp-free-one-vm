# Create network stack
resource "google_compute_network" "vpc-network" {
  provider                = google
  name                    = var.vpc_network
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

# Create a subnetwork within the VPC
resource "google_compute_subnetwork" "vpc-subnet" {
  name                     = var.vpc_subnet
  ip_cidr_range            = "10.0.0.0/24"
  region                   = var.region
  network                  = google_compute_network.vpc-network.id
}

# Create a firewall rule to allow SSH access via IAP
resource "google_compute_firewall" "allow-iap-ssh-ingress" {
  name      = "allow-iap-ssh-ingress"
  network   = google_compute_network.vpc-network.name
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Create an internal IP address for MySQL
resource "google_compute_address" "mysql-internal-ip" {
  name         = var.mysql_vm
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.vpc-subnet.id
  purpose      = "GCE_ENDPOINT"
}

# Create Service Accounts and IAM Roles
resource "google_service_account" "sa-mysql-vm" {
  project      = var.project_id
  account_id   = var.mysql_vm_sa
  display_name = "Service Account for MySQL VM"
}

# Create a static external IP address
resource "google_compute_address" "this" {
  name   = "wp-compute-address"
  region = "us-central1"
}

# Create a firewall rule to allow HTTP and HTTPS traffic
resource "google_compute_firewall" "wordpress_ingress" {
  name    = "wp-http"
  network = google_compute_network.vpc-network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Create a compute instance
resource "google_compute_instance" "this" {
 name                    = var.mysql_vm
 machine_type            = var.machine_type
 zone                    = var.zone
  metadata_startup_script = templatefile("${path.module}/init.sh", {
    DB_USERNAME       = random_string.this.result
    DB_HOST           = var.db_host_name
    WORDPRESS_DB_NAME = var.wordpress_db_name
    WORDPRESS_DB_USER = random_string.this.result
    DB_USER_PASSWORD  = random_password.this.result
    DB_ROOT_PASSWORD  = random_password.this.result    
  })

 boot_disk {
  auto_delete = "true"
   initialize_params {
     image = "debian-cloud/debian-12"
     size  = 30
     type  = "pd-standard"
   }
 }

 network_interface {
   subnetwork = google_compute_subnetwork.vpc-subnet.id
   network_ip = google_compute_address.mysql-internal-ip.address
   access_config {
     nat_ip = google_compute_address.this.address
   }
 }

 service_account {
   email  = google_service_account.sa-mysql-vm.email
   scopes = ["userinfo-email", "compute-ro", "storage-ro","cloud-platform"]
 }
}

# Generate a random string of 24 characters. 
# The string will contain at least 5 uppercase and 5 lowercase letters.
resource "random_string" "this" {
 length    = 24
 special   = false
 min_upper = 5
 min_lower = 5
}

# Generate a random password of 24 characters. 
# The password will contain at least 5 uppercase and 5 lowercase letters.
resource "random_password" "this" {
 length    = 24
 special   = false
 min_upper = 5
 min_lower = 5
}

# Output the external IP address of the Google Compute Instance
output "external-ip" {
  value = google_compute_instance.this.network_interface[0].access_config[0].nat_ip
}
