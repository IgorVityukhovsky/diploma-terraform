terraform {
  backend "s3" {
      endpoint = "storage.yandexcloud.net"
      bucket   = "s3diploma"
      region   = "ru-central1-a"
      key      = "testfolder/terraform.tfstate"
      access_key = "YCAJEetwy6-Go_N3HGQAk0gTZ"
      secret_key = "${var.TF_VAR_KEY_S3}"
      

      skip_region_validation      = true
      skip_credentials_validation = true
    }
}
