variable "username" {
  description = "The username for the VM instance"
  default     = "igor"
}

variable "TF_VAR_KEY_PUB" {
  description = "public key SSH (will be changed)"
  default     = "will_be_changed"
}

variable "TF_VAR_KEY_PRIVAT" {
  description = "private key SSH (will be changed)"
  default     = "will_be_changed"
}

resource "yandex_compute_instance" "kuber-1" {
  name     = "kuber1"
  hostname = "kuber1"
  zone     = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8t08ih94rivuk5q46j" #ubuntu 20.04
      name     = "kuber1"
      size     = "30"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    nat            = true
    nat_ip_address = "84.201.133.55"
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${TF_VAR_KEY_PUB}"
  }

  provisioner "file" {
    source      = "/home/igor/.ssh/yandex/ya_key"
    destination = "/home/${var.username}/.ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/${var.username}/.ssh/id_rsa"
    ]
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
}

resource "yandex_compute_instance" "kuber-2" {
  name     = "kuber2"
  hostname = "kuber2"
  zone     = "ru-central1-b"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8t08ih94rivuk5q46j" #ubuntu 20.04
      name     = "kuber2"
      size     = "30"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-2.id
    nat            = true
    nat_ip_address = "158.160.79.40"
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${TF_VAR_KEY_PUP}"
  }
}

resource "yandex_compute_instance" "kuber-3" {
  name     = "kuber3"
  hostname = "kuber3"
  zone = "ru-central1-c"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8t08ih94rivuk5q46j" #ubuntu 20.04
      name     = "kuber3"
      size     = "30"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-3.id
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${TF_VAR_KEY_PUP}"
  }
}
