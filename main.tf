#Data sources

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  for_each = var.vms
  name          = each.value.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name = var.vm_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

/*
data "vsphere_content_library" "library" {
  name = var.vsphere_content_library
}

data "vsphere_content_library_item" "library_item" {
  name       = var.vm_template_name
  type       = var.vsphere_content_library_item_type
  library_id = data.vsphere_content_library.library.id
}
*/

#Resource

resource "vsphere_virtual_machine" "vm" {
  for_each = var.vms

  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = var.vm_guest_id
  folder           = var.vm_folder_name

  cdrom {
    client_device = true
  }

  network_interface {
    network_id = data.vsphere_network.network[each.key].id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  name     = each.value.vm_name
  num_cpus = each.value.vm_vcpu
  memory   = each.value.vm_memory
  firmware		= var.vm_firmware
  /*
  disk {
    label            = var.vm_disk_label
    size             = each.value.vm_disk_size
    thin_provisioned = var.vm_disk_thin
  }
*/

  disk {

    # First disk (default unit_number 0)

    label = "primary_disk"

    size = 300

  }

  disk {

    # Second disk with a unique unit_number

    label = "secondary_disk0"

    size = 50

    unit_number = 1

  }

    disk {

    # Second disk with a unique unit_number

    label = "secondary_disk1"

    size = 50

    unit_number = 2

  }

    disk {

    # Second disk with a unique unit_number

    label = "secondary_disk2"

    size = 50

    unit_number = 3

  }


  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name   = each.value.vm_name
        admin_password = var.admin_password
        time_zone = "20" 
        auto_logon = false
#        auto_logon_count = 2
        run_once_command_list = [  
          "powershell.exe -ExecutionPolicy Bypass net user Administrator /logonpasswordchg:yes; logoff",
	        "powershell.exe -ExecutionPolicy Bypass Get-Disk | Where-Object IsOffline -Eq $True | Set-Disk -IsOffline $False"
        ]

        #domain      = var.vm_domain
        #script_text = var.script_text

      }
      network_interface {
        ipv4_address    = each.value.vm_ip
        ipv4_netmask    = var.vm_ipv4_netmask
        dns_server_list = var.vm_dns_servers
      }

      ipv4_gateway = var.vm_ipv4_gateway
    }

  }
  

}
