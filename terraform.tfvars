#Infrastructure

vsphere_datacenter      = "DFW3-802724-01"
vsphere_compute_cluster = "DFW3-802724-01-Cluster-01"
vsphere_datastore       = "1356360-dsan-fc-hlu1-Powerstore"
vsphere_resource_pool   = "Compute-ResourcePool"
vsphere_network         = "dfw-mgmt-01"

#VM

vm_template_name = "DFW-win22-all-tmpl"
vm_guest_id      = "windows2019srvNext_64Guest"
vm_ipv4_netmask  = "24"
vm_ipv4_gateway  = "172.29.0.1"
vm_dns_servers   = ["72.3.128.240", "72.3.128.241"]
#vm_disk_label   = "disk0"
#vm_disk_thin    = "true"
vm_domain      = "example.com"
vm_folder_name = "Workloads"
vm_firmware    = "efi"

vms = {
  Windows1 = {
    vm_name   = "dfw-p-w-maj-all-01"
    vm_ip     = "172.29.0.11"
    vm_vcpu   = "2"
    vm_memory = "4096"
    #vm_disk_size = "300"
    vm_network = "dfw-mgmt-01"
  }
  Windows2 = {
    vm_name   = "dfw-p-w-maj-all-02"
    vm_ip     = "172.29.0.12"
    vm_vcpu   = "2"
    vm_memory = "4096"
    # vm_disk_size = "300"
    vm_network = "dfw-mgmt-01"
  }
}
