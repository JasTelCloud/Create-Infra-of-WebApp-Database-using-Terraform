// private-firewall of mysql-cluster
resource "digitalocean_database_firewall" "private_firewall" {
  cluster_id = digitalocean_database_cluster.mysql_cluster.id

  rule {
    type  = "ip_addr"
    value = "10.10.10.0/24"
  }
  rule {
    type  = "droplet"
    value = digitalocean_droplet.my_wordpress_01.id
  }
}

// resource "digitalocean_firewall" "myprivate" {
//   name = "private-rules"

//   droplet_ids = [digitalocean_droplet.newDroplet02.id]

//   inbound_rule {
//     protocol         = "tcp"
//     port_range       = "22"
//     source_addresses = ["10.10.10.0/24"]
//   }
//   inbound_rule {
//     protocol         = "icmp"
//     source_addresses = ["10.10.10.0/24"]
//   }

// }