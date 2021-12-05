
locals {
  postfix = var.name_postfix != "" ? var.name_postfix : random_id.id.hex
  domain  = var.cf_domain == "" ? data.hsdp_config.cf[0].domain : var.cf_domain
}
resource "random_id" "id" {
  byte_length = 4
}

data "hsdp_config" "cf" {
  count   = var.cf_domain == "" ? 1 : 0
  service = "cf"
}
data "cloudfoundry_org" "org" {
  name = var.cf_org
}
data "cloudfoundry_space" "space" {
  org  = data.cloudfoundry_org.org.id
  name = var.cf_space
}
data "cloudfoundry_domain" "domain" {
  name = local.domain
}

resource "cloudfoundry_app" "service_proxy" {
  name         = "tf-service-proxy-${local.postfix}"
  space        = data.cloudfoundry_space.space.id
  memory       = 128
  disk_quota   = 512
  docker_image = var.caddy_image
  environment = {
    CADDYFILE_BASE64 = base64encode(templatefile("${path.module}/templates/Caddyfile", {
      upstream_urls = var.upstream_urls
      upstream_default = var.upstream_default
      response_str = "<html><h1>Service Proxy</h1><ul>%{ for path, url in var.upstream_urls }<li><a href='${path}/'>${path}/</a>%{ endfor }</ul></html>"
    }))
  }

  command           = "echo $CADDYFILE_BASE64 | base64 -d > /etc/caddy/Caddyfile && cat /etc/caddy/Caddyfile && caddy run -config /etc/caddy/Caddyfile "
  health_check_type = "process"
  routes {
    route = cloudfoundry_route.service_proxy.id
  }
}

resource "cloudfoundry_route" "service_proxy" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = data.cloudfoundry_space.space.id
  hostname = "tf-service-proxy-${local.postfix}"
}

