provider "aci" {
  username = "${var.aciUser}"
  private_key = "${var.aciPrivateKey}"
  cert_name = "${var.aciCertName}"
  insecure = true
  url = "${var.aciUrl}"
}

data "aci_tenant" "demo"{
  name = var.tenantName
}

data "aci_bridge_domain" "demo-bd" {
    tenant_dn          = "${data.aci_tenant.demo.id}"
    name               = "demo-bd"
}

data "aci_application_profile" "demo-app" {
    tenant_dn          = "${data.aci_tenant.demo.id}"
    name               = "demo-application"
}

resource "aci_application_epg"  "app-epg" {
application_profile_dn = "${data.aci_application_profile.demo-app.id}"
name                   = "app"
relation_fv_rs_bd      = "${data.aci_bridge_domain.demo-bd.name}"
}
