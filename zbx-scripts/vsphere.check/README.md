vsphere.check
=============

This script use the vSphere API to discover and manage vSphere Infrastructure.

Installation
------------

1. Install `vsphere.check` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then chmod a+x `vsphere.check`
3. Install nokogiri gem `sudo gem install nokogiri --version=1.5.10`. Please ensure that your system has the following [requirements](http://nokogiri.org/tutorials/installing_nokogiri.html).
4. Install rbvmomi gem `sudo gem  install rbvmomi`

### Requirements

This script was tested for Zabbix 2.0.0 or higher on a large VMWARE Infrastructure.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

###### [Nokogiri](http://nokogiri.org) 1.5.10

This script require Nokogiri gem 1.5.10. If you use Ruby 1.9.x you casn use higher version.

###### [rbvmomi](https://github.com/vmware/rbvmomi) 1.6.00

This script require rbvmomi gem 1.6.0. or higher.

Usage
-----

### As a script
    ./vsphere.check [OPTIONS]

    where OPTIONS are :
      -h, --help                       Display this help message
      -k, --key KEY                    Query key. Available keys are:
                                        api.call
                                        api.status
                                        api.serial
                                        hosts.discovery
                                        host.hostname
                                        host.product
                                        host.hardwaremodel
                                        host.cpumodel
                                        host.cpumhz
                                        host.cpucore
                                        host.cpuusage
                                        host.totalmemorysize
                                        host.memoryusage
                                        host.powerstate
                                        host.maintenancemode
                                        host.uptime
                                        host.overallstatus
                                        datastores.discovery
                                        datastore.name
                                        datastore.capacity
                                        datastore.freespace
                                        datastore.vmcount
                                        datastore.vmlist
                                        virtualmachines.discovery
                                        virtualmachine.name
                                        virtualmachine.runninghost
                                        virtualmachine.powerstate
                                        virtualmachine.guestfullname
                                        virtualmachine.hostname
                                        virtualmachine.ipaddress
                                        virtualmachine.vmwaretools
                                        virtualmachine.maxcpuusage
                                        virtualmachine.numcpu
                                        virtualmachine.overallcpuusage
                                        virtualmachine.memorysizemb
                                        virtualmachine.hostmemoryusage
                                        virtualmachine.guestmemoryusage
                                        virtualmachine.uncommittedstorage
                                        virtualmachine.usedstorage
                                        virtualmachine.unsharedstorage
                                        virtualmachine.storagelocation
                                        virtualmachine.uptime
                                        virtualmachine.overallstatus
      -i, --item ITEM                  Host, Datastore, VirtualMachine name to query
      -v, --vcenter VCENTER            FQDN or IP address of your vCenter
      -u, --username USERNAME          vCenter username
      -p, --password PASSWORD          vCenter password
      -o, --output-dir DIRECTORY       Directory where to save json and log files


### As an item
Use `vsphere.check` like an **External Check** item in Zabbix.  So, when creating an item, select **External Check**.  In the **Key** field, you specify:

    vsphere.check["-q","key","-i","item","-v","vcenter","-u","username","-p","password","-o","dir"]

Version
-------

Version 2.0.5

License
-------

This scriptis distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
