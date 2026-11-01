
resource "terraform_data" "linux_hostname" {
  for_each = {
    for key, vm in local.linux_vms :
    key => vm
    if contains(keys(azurerm_public_ip.linux_pip), key)
  }

  triggers_replace = [
    azurerm_linux_virtual_machine.linux_vm[each.key].id
  ]

  connection {
    type = "ssh"

    host = azurerm_public_ip.linux_pip[each.key].ip_address
    user = var.admin_username

    private_key = file(pathexpand(var.ssh_private_key_path))
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "hostname"
    ]
  }

  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]
}

