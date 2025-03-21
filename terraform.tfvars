#Infrastructure

vsphere_datacenter      = "ORD1-802724-01"
vsphere_compute_cluster = "ORD1-802724-01-Cluster-01"
# vsphere_datastore       = "1356359-dsan-fc-hlu2-Powerstore"
datastore_cluster       = "1356359-dsan-fc-hlu-Powerstore"
vsphere_resource_pool   = "Compute-ResourcePool"
vsphere_network         = "ord-mgmt-01"

#VM

vm_template_name = "ord-win22-all-tmpl-new"
vm_guest_id      = "windows2019srvNext_64Guest"
vm_ipv4_netmask  = "24"
vm_ipv4_gateway  = "172.28.0.1"
vm_dns_servers   = ["172.28.0.2", "172.28.0.3"]
#vm_disk_label   = "disk0"
#vm_disk_thin    = "true"
vm_domain      = "rfxcel.net"
vm_folder_name = "Workloads"
vm_firmware    = "bios"

vms = {
  Windows1 = {
    vm_name   = "ord-p-w-maj-all-01"
    vm_ip     = "172.28.0.50"
    vm_vcpu   = "2"
    vm_memory = "4096"
    #vm_disk_size = "300"
    vm_network = "ord-mgmt-01"
  }
  Windows2 = {
    vm_name   = "ord-p-w-maj-all-02"
    vm_ip     = "172.28.0.51"
    vm_vcpu   = "2"
    vm_memory = "4096"
    # vm_disk_size = "300"
    vm_network = "ord-mgmt-01"
  }
}
