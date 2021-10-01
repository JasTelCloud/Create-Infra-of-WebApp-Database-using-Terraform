terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.11.1"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "mykey01" {
  name       = "mykeyname"
  public_key = file("~/.ssh/id_rsa.pub")
}

// vpc
resource "digitalocean_vpc" "vpc01" {
  name     = "myvpc01"
  region   = "sgp1"
  ip_range = "10.10.10.0/24"
}

// my-wordpress-01
resource "digitalocean_droplet" "my_wordpress_01" {
  name     = "my-wordpress-01"
  image    = "wordpress-20-04"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.mykey01.fingerprint]
  vpc_uuid = digitalocean_vpc.vpc01.id
}

// mysql-cluster
resource "digitalocean_database_cluster" "mysql_cluster" {
  name       = "mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "sgp1"
  node_count = 1
  private_network_uuid = digitalocean_vpc.vpc01.id
}

