# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id  = "b1g8rvrldf45r9h4mnbl"
  folder_id = "b1gcj17iv37qg7h91dfe"
}
