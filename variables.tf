variable "cf_org" {
  type        = string
  description = "The CF Org to deploy under"
}
variable "cf_space" {
  type        = string
  description = "The CF Space to deploy in"
}
variable "cf_domain" {
  type        = string
  description = "The CF domain to use for Proxy"
  default     = ""
}
variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the hostname, prevents namespace clashes"
  default     = ""
}
variable "cf_username" {
  type        = string
  description = "Cloud foundry username"
}

variable "cf_password" {
  type        = string
  description = "Cloud foundry password"
  sensitive   = true
}

variable "cf_api" {
  default     = "https://api.cloud.pcftest.com"
  type        = string
  description = "Cloud foundry API endpoint (region specific)"
}

variable "caddy_image" {
  type        = string
  description = "Caddy Docker image to use"
  default     = "caddy:2.4.5"
}

variable "upstream_urls" {
  type = map(string)
  description = "Upstream urls with path. Format: path = url (These urls will be accessible at respective paths in proxy)"
}

variable "upstream_default" {
  type        = string
  description = "Set this if you have only single upstream url and want that to be proxied by default (Without any path variable)"
  default     = ""
}

variable "docker_credentials" {
  type        = map
  description = "Set this if you have only single upstream url and want that to be proxied by default (Without any path variable)"
 
}

