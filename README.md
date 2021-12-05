

# terraform-cloudfoundry-serviceproxy
Creates a proxy for one or more service instances in cloudfoundry

## Usage Instruction

Clone the project locally and add a terraform.tfvars file. Set the variables as provided in the folliing sample:

```hcl
cf_org      = "<< your cf org here>>"
cf_space    = "<< your cf space here>>"
cf_username = "<< your cf username here>>"
cf_password = "<< your cf password here>>"

upstream_default = <<the upstream service url and port that need to be proxied>>

```
If additional services/urls need to be proxied, update the upstream_urls in tfvars file as follows:

```hcl
upstream_urls = {
    #format: path=url (The urls will be accessible at respective paths in proxy)
  "/<<path 1>>"    = "<<url 1>>"
  "/<<path 2>>"    = "<<url 2>>"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| cloudfoundry | >= 0.14.2|
| HSDP | >= 0.27.9|
| random | >= 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| cloudfoundry | >=0.14.2 |
| random | >= 2.2.1 |
| HSDP | >= 0.27.9|

## Outputs

| Name | Description |
|------|-------------|
| proxy_endpoint | The default proxy endpoint |
| proxy_paths_generated | The path urls for all configured proxy paths  |


# Contact / Getting help
gireesh.nemath@philips.com

# License
License is MIT
