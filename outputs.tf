output "external_ip_address_kuber1" {
  value = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
}

output "external_ip_address_kuber2" {
  value = yandex_compute_instance.kuber-2.network_interface.0.nat_ip_address
}

output "internal_ip_address_kuber1" {
  value = yandex_compute_instance.kuber-1.network_interface.0.ip_address
}

output "internal_ip_address_kuber2" {
  value = yandex_compute_instance.kuber-2.network_interface.0.ip_address
}

output "internal_ip_address_kuber3" {
  value = yandex_compute_instance.kuber-3.network_interface.0.ip_address
}

