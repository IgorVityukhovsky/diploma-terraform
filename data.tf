locals {
  common_vars = {
    internal_ip_address_kuber1 = "${yandex_compute_instance.kuber-1.network_interface.0.ip_address}"
    internal_ip_address_kuber2 = "${yandex_compute_instance.kuber-2.network_interface.0.ip_address}"
    internal_ip_address_kuber3 = "${yandex_compute_instance.kuber-3.network_interface.0.ip_address}"
    user                       = "${var.username}"
    ansible_user               = "${var.username}"
  }
}

data "template_file" "hosts" {
  template = "${file("./template-hosts.yaml.tpl")}"  
  vars     = local.common_vars
}

resource "null_resource" "hosts" {
  triggers = {
    template_rendered = "${data.template_file.hosts.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.hosts.rendered}' > hosts.yaml"
 }
  provisioner "file" {
    source      = "./hosts.yaml"
    destination = "/home/${var.username}/hosts.yaml"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
}

data "template_file" "pre-script" {
  template = "${file("./template-script.sh.tpl")}"  
  vars     = local.common_vars
}

resource "null_resource" "pre-script" {
  triggers = {
    template_rendered = "${data.template_file.pre-script.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.pre-script.rendered}' > pre-script.sh"
 }
  provisioner "file" {
    source      = "./pre-script.sh"
    destination = "/home/${var.username}/pre-script.sh"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 744 /home/${var.username}/pre-script.sh"
    ]
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "file" {
    source      = "./ingress.yml"
    destination = "/home/${var.username}/ingress.yml"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "file" {
    source      = "./my-app-svc.yml"
    destination = "/home/${var.username}/my-app-svc.yml"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "file" {
    source      = "./my-app-deploy.yml"
    destination = "/home/${var.username}/my-app-deploy.yml"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "file" {
    source      = "./jen.yml"
    destination = "/home/${var.username}/jen.yml"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "file" {
    source      = "./post-script.sh"
    destination = "/home/${var.username}/post-script.sh"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 744 /home/${var.username}/post-script.sh"
    ]
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.TF_VAR_KEY_PRIVATE}"
      host        = yandex_compute_instance.kuber-1.network_interface.0.nat_ip_address
    }
  }
}


