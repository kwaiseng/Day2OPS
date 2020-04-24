provider "aci" {
  username = "${var.aciUser}"
  private_key = "${var.aciPrivateKey}"
  cert_name = "${var.aciCertName}"
  insecure = true
  url = "${var.aciUrl}"
}

resource "aci_tenant" "demo"{
  name = "${var.tenantName}"
  description = "Created by Terraform"
}

resource "aci_vrf" "demo-vrf" {
    tenant_dn   = "${aci_tenant.demo.id}"
    name        = "demo-vrf"
}

resource "aci_bridge_domain" "demo-bd" {
    tenant_dn          = "${aci_tenant.demo.id}"
    relation_fv_rs_ctx = "${aci_vrf.demo-vrf.name}"
    name               = "demo-bd"
}

resource "aci_subnet" "subnet" {
    bridge_domain_dn = "${aci_bridge_domain.demo-bd.id}"
    ip               = "1.2.3.1/24"
    scope            = "public"
}

resource "aci_application_profile" "demo-app" {
    tenant_dn          = "${aci_tenant.demo.id}"
    name               = "demo-application"
}

resource "aci_application_epg"  "web-epg" {
application_profile_dn = "${aci_application_profile.demo-app.id}"
name                   = "web"
relation_fv_rs_bd      = "${aci_bridge_domain.demo-bd.name}"
}
