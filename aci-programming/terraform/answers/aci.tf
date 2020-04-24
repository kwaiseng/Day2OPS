provider "aci" {
  username = "${var.aciUser}"
  private_key = "${var.aciPrivateKey}"
  cert_name = "${var.aciCertName}"
  insecure = true
  url = "${var.aciUrl}"
}

resource "aci_tenant" "demo"{
  name = "${var.tenantName}"
  description = "Created by kslai Terraform"
}
