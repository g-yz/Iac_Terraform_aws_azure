output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "The name of the deployed virtual machine."
}

output "vm_private_ip" {
  value       = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
  description = "The private IP address of the virtual machine."
}
