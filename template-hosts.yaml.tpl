all:
  hosts:
    node1:
      ansible_host: ${internal_ip_address_kuber1}
      ansible_user: ${ansible_user}
      ip: ${internal_ip_address_kuber1}
      access_ip: ${internal_ip_address_kuber1}
    node2:
      ansible_host: ${internal_ip_address_kuber2}
      ansible_user: ${ansible_user}
      ip: ${internal_ip_address_kuber2}
      access_ip: ${internal_ip_address_kuber2}
    node3:
      ansible_host: ${internal_ip_address_kuber3}
      ansible_user: ${ansible_user}
      ip: ${internal_ip_address_kuber3}
      access_ip: ${internal_ip_address_kuber3}
  children:
    kube_control_plane:
      hosts:
        node1:
    kube_node:
      hosts:
        node2:
        node3:
    etcd:
      hosts:
        node1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
