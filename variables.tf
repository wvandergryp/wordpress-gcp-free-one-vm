# These values MUST be configured
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

# Google Cloud Resource Locations
variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}
variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

# Google Cloud Network Names
variable "vpc_network" {
  description = "VPC Network"
  type        = string
  default     = "wp-network"
}
variable "vpc_subnet" {
  description = "VPC Subnet"
  type        = string
  default     = "wp-subnet"
}

# Google Cloud Compute Resource Names
# These values MUST be configured - this is now used for the service account
variable "mysql_vm" {
  description = "MySQL VM"
  type        = string
}
variable "machine_type" {
  description = "WordPress host machine type"
  type        = string
  default = "e2-micro"
}

# Google Cloud Compute Service Account Names
# These values MUST be configured
variable "mysql_vm_sa" {
  description = "MySQL VM Service Account"
  type        = string
}

# Wordpress Configuration
# Table prefix can be left as-is, but DB values MUST be configured
variable "wordpress_table_prefix" {
  description = "WordPress DB Table Prefix"
  type        = string
  default     = "wp_"
}
variable "wordpress_db_name" {
  description = "WordPress DB Name"
  type        = string
  default     = "wordpress01"
}
variable "db_host_name" {
  description = "WordPress DB hostname"
  type        = string
  default = "localhost"
}