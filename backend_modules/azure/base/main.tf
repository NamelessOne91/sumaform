locals {
  name_prefix                          = var.name_prefix

  create_network                       = lookup(var.provider_settings, "create_network", true)
  location                             = lookup(var.provider_settings, "location", null)
  ssh_allowed_ips                      = lookup(var.provider_settings, "ssh_allowed_ips", [])
  additional_network                   = lookup(var.provider_settings, "additional_network", "172.16.2.0/24")

  public_subnet_id                     = lookup(var.provider_settings, "public_subnet_id", null)
  private_subnet_id                    = lookup(var.provider_settings, "private_subnet_id", null)
  private_additional_subnet_id         = lookup(var.provider_settings, "private_additional_subnet_id", null)
  public_security_group_id             = lookup(var.provider_settings, "public_security_group_id", null)
  private_security_group_id            = lookup(var.provider_settings, "private_security_group_id", null)
  private_additional_security_group_id = lookup(var.provider_settings, "private_additional_security_group_id", null)
  bastion_host                         = lookup(var.provider_settings, "bastion_host", null)
  public_key_location = lookup(var.provider_settings, "public_key_location", null)
  key_file = lookup(var.provider_settings, "key_file", null)
}

module "network" {
  source = "../network"

  location           = local.location
  ssh_allowed_ips    = local.ssh_allowed_ips
  name_prefix        = local.name_prefix
  create_network     = local.create_network
  additional_network = local.additional_network
}

locals {
  configuration_output = merge({
    cc_username          = var.cc_username
    cc_password          = var.cc_password
    timezone             = var.timezone
    use_ntp              = var.use_ntp
    ssh_key_path         = var.ssh_key_path
    mirror               = var.mirror
    use_mirror_images    = var.use_mirror_images
    use_avahi            = var.use_avahi
    domain               = var.domain
    name_prefix          = var.name_prefix
    use_shared_resources = var.use_shared_resources
    testsuite            = var.testsuite

    additional_network   = local.additional_network

    location             = local.location

    public_key_location  = local.public_key_location
    key_file             = local.key_file
    resource_group_name  = module.network.configuration.resource_group_name
    platform_image_info  = {
      suma-server-50-arm64-ltd-paygo  = { platform_image = data.azurerm_platform_image.suma-server-50-arm64-ltd-paygo },
      suma-proxy-50-arm64-byos        = { platform_image = data.azurerm_platform_image.suma-proxy-50-arm64-byos },
      suma-server-50-x86_64-ltd-paygo = { platform_image = data.azurerm_platform_image.suma-server-50-x86_64-ltd-paygo },
      suma-proxy-50-x86_64-byos       = { platform_image = data.azurerm_platform_image.suma-proxy-50-x86_64-byos },
      smlm-server-51-arm64-ltd-paygo  = { platform_image = data.azurerm_platform_image.smlm-server-51-arm64-ltd-paygo },
      smlm-proxy-51-arm64-byos        = { platform_image = data.azurerm_platform_image.smlm-proxy-51-arm64-byos },
      smlm-server-51-x86_64-ltd-paygo = { platform_image = data.azurerm_platform_image.smlm-server-51-x86_64-ltd-paygo },
      smlm-proxy-51-x86_64-byos       = { platform_image = data.azurerm_platform_image.smlm-proxy-51-x86_64-byos },
      opensuse156o = { platform_image = data.azurerm_platform_image.opensuse156o },
      sles15sp4o   = { platform_image = data.azurerm_platform_image.sles15sp4o },
      sles15sp5o   = { platform_image = data.azurerm_platform_image.sles15sp5o },
      sles15sp6o   = { platform_image = data.azurerm_platform_image.sles15sp6o },
      sles12sp5o   = { platform_image = data.azurerm_platform_image.sles12sp5o },
      ubuntu2004   = { platform_image = data.azurerm_platform_image.ubuntu2004 },
      ubuntu2204   = { platform_image = data.azurerm_platform_image.ubuntu2204 },
      ubuntu2404   = { platform_image = data.azurerm_platform_image.ubuntu2404 },
      rhel9        = { platform_image = data.azurerm_platform_image.rhel9 },
      rhel8        = { platform_image = data.azurerm_platform_image.rhel8 },
    }
    },
    local.create_network ? module.network.configuration : {
      public_subnet_id                     = local.public_subnet_id
      private_subnet_id                    = local.private_subnet_id
      private_additional_subnet_id         = local.private_additional_subnet_id
      public_security_group_id             = local.public_security_group_id
      private_security_group_id            = local.private_security_group_id
      private_additional_security_group_id = local.private_additional_security_group_id
  },
  )
}

module "bastion" {
  source                        = "../host"
  quantity                      = local.create_network ? 1 : 0
  base_configuration            = local.configuration_output
  image                         = "opensuse156o"
  name                          = "bastion"
  connect_to_additional_network = true
  provider_settings = {
    vm_size = "Standard_B1s"
    public_instance = true
  }
}

output "configuration" {
    value = merge(local.configuration_output, {
    bastion_host = local.create_network ? (length(module.bastion.configuration.public_names) > 0 ? module.bastion.configuration.public_names[0] : null) : local.bastion_host
  })
}
