output "proxy_endpoint" {
  description = "The endpoint where Service Proxy is reachable on"
  value       = cloudfoundry_route.service_proxy.endpoint
}
output "proxy_paths_generated" {
  value = [
    for k,v in var.upstream_urls : format("%s%s/  ==>  %s",cloudfoundry_route.service_proxy.endpoint, k , v)
  ]
}
