data "azurerm_platform_image" "suma-server-50-arm64-ltd-paygo" {
  location  = local.location
  publisher = "suseirelandltd1692213356027"
  offer     = "manager-server-5-0-arm64-ltd-image"
  sku       = "gen2"
}

data "azurerm_platform_image" "suma-proxy-50-arm64-byos" {
  location  = local.location
  publisher = "suse"
  offer     = "manager-proxy-5-0-byos-arm64"
  sku       = "gen2"
}

data "azurerm_platform_image" "suma-server-50-x86_64-ltd-paygo" {
  location  = local.location
  publisher = "suseirelandltd1692213356027"
  offer     = "manager-server-5-0-ltd-image"
  sku       = "gen2"
}

data "azurerm_platform_image" "suma-proxy-50-x86_64-byos" {
  location  = local.location
  publisher = "suse"
  offer     = "manager-proxy-5-0-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "smlm-server-51-arm64-ltd-paygo" {
  location  = local.location
  publisher = "suse-ltd"
  offer     = "manager-server-5-1-arm64-ltd-image"
  sku       = "gen2"
}

data "azurerm_platform_image" "smlm-proxy-51-arm64-byos" {
  location  = local.location
  publisher = "suse"
  offer     = "manager-proxy-5-1-byos-arm64"
  sku       = "gen2"
}

data "azurerm_platform_image" "smlm-server-51-x86_64-ltd-paygo" {
  location  = local.location
  publisher = "suse-ltd"
  offer     = "manager-server-5-1-ltd-image"
  sku       = "gen2"
}

data "azurerm_platform_image" "smlm-proxy-51-x86_64-byos" {
  location  = local.location
  publisher = "suse"
  offer     = "manager-proxy-5-0-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "opensuse156o" {
  location  = local.location
  publisher = "suse"
  offer     = "opensuse-leap-15-6"
  sku       = "gen2"
}

data "azurerm_platform_image" "sles12sp5o" {
  location  = local.location
  publisher = "suse"
  offer     = "sles-12-sp5-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "sles15sp4o" {
  location  = local.location
  publisher = "suse"
  offer     = "sles-15-sp4-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "sles15sp5o" {
  location  = local.location
  publisher = "suse"
  offer     = "sles-15-sp5-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "sles15sp6o" {
  location  = local.location
  publisher = "suse"
  offer     = "sles-15-sp6-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "sles15sp7o" {
  location  = local.location
  publisher = "suse"
  offer     = "sles-15-sp7-byos"
  sku       = "gen2"
}

data "azurerm_platform_image" "rhel8" {
  location  = local.location
  publisher = "RedHat"
  offer     = "RHEL"
  sku       = "8-lvm-gen2"
}

data "azurerm_platform_image" "rhel9" {
  location  = local.location
  publisher = "redhat"
  offer     = "RHEL"
  sku       = "9-lvm-gen2"
}

data "azurerm_platform_image" "ubuntu2004" {
  location  = local.location
  publisher = "cognosys"
  offer     = "ubuntu-20-04-lts"
  sku       = "ubuntu-20-04-lts"
}

data "azurerm_platform_image" "ubuntu2204" {
  location  = local.location
  publisher = "cognosys"
  offer     = "ubuntu-22-04-lts"
  sku       = "ubuntu-22-04-lts"
}

/* data "azurerm_platform_image" "ubuntu2404" {
  location  = local.location
  publisher = "cognosys"
  offer     = "ubuntu-24-04-lts"
  sku       = "ubuntu-24-04-lts"
} */