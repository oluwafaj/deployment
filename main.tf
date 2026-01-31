resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name 
    tags                = var.tags
}

resource "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = var.tags
}

resource "azurerm_network_interface" "vm_nic" {
  count               = var.virtual_machine_count
  name                = "${var.virtual_machine_name_prefix}-nic-${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "main" {
  count               = var.virtual_machine_count
  name                = "${var.virtual_machine_name_prefix}-${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  network_interface_ids = [
    azurerm_network_interface.vm_nic[count.index].id,
  ]
  vm_size             = var.virtual_machine_size

  storage_os_disk {
    name              = "${var.virtual_machine_name_prefix}-osdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.virtual_machine_name_prefix}-${count.index + 1}"
    admin_username = var.admin_username
    admin_password = "P@ssw0rd1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}

# Import the Network
import {
  to = azurerm_virtual_network.main
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/virtualNetworks/deployment-vnet"
}

# Import the Storage Account (The one you want to change to GRS)
import {
  to = azurerm_storage_account.main
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Storage/storageAccounts/deploymentstorage1993"
}

# Import the VMs (Example for VM 1)
import {
  to = azurerm_virtual_machine.main[0]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Compute/virtualMachines/depl-vm-1"
}

import {
  to = azurerm_virtual_machine.main[1]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Compute/virtualMachines/depl-vm-2"
}

import {
  to = azurerm_virtual_machine.main[2]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Compute/virtualMachines/depl-vm-3"
}

import {
  to = azurerm_virtual_machine.main[3]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Compute/virtualMachines/depl-vm-4"
}
import {
  to = azurerm_virtual_machine.main[4]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Compute/virtualMachines/depl-vm-5"
}

# Import the Subnet (This fixes the 1 to add)
import {
  to = azurerm_subnet.main
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/virtualNetworks/deployment-vnet/subnets/deployment-subnet"
}

# Import the 5 NICs (This fixes the 5 to add)
import {
  to = azurerm_network_interface.vm_nic[0]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/networkInterfaces/depl-vm-nic-1"
}

import {
  to = azurerm_network_interface.vm_nic[1]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/networkInterfaces/depl-vm-nic-2"
}

import {
  to = azurerm_network_interface.vm_nic[2]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/networkInterfaces/depl-vm-nic-3"
}

import {
  to = azurerm_network_interface.vm_nic[3]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/networkInterfaces/depl-vm-nic-4"
}

import {
  to = azurerm_network_interface.vm_nic[4]
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg/providers/Microsoft.Network/networkInterfaces/depl-vm-nic-5"
}

import {
  to = azurerm_resource_group.main
  id = "/subscriptions/6a012649-9e7f-4cec-b5d7-d4adee64fbbf/resourceGroups/deployment-rg"
}