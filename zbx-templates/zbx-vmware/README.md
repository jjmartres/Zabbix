ZBX-VMWARE
==========

This template can manage VMware vCenter (both VCSA and Windows version). If you want to manage VMware ESX(i) or vSphere infrastructure please take a look to [VIMbix](https://github.com/jjmartres/VIMbix)

Items
-----

  * VMware vSphere Web Client Service Port
  * VMware vSphere Web Client Service
  * VMware vSphere Update Manager Service port
  * VMware vSphere Update Manager
  * VMware vSphere AutoDeploy Service Port
  * VMware vSphere AutoDeploy Service
  * VMware vCenter Single Sign On Service Port
  * VMware vCenter Single Sign On Service
  * VMware vCenter Server Service
  * VMware vCenter Server Port
  * VMware vCenter Inventory Service Port
  * VMware vCenter Inventory Service

Triggers
--------

  * **[HIGH]** => VMware vCenter Single Sign On port is unreachable
  * **[HIGH]** => VMware vSphere Web Client service is down
  * **[HIGH]** => VMware vSphere Update Manager port is unreachable
  * **[HIGH]** => VMware vCenter AutoDeploy port is unreachable
  * **[HIGH]** => VMware vCenter AutoDeploy service is down
  * **[HIGH]** => VMware vSphere Web Client port is unreachable
  * **[HIGH]** => VMware vSphere Update Manager service is down
  * **[HIGH]** => VMware vCenter Inventory service is down
  * **[HIGH]** => VMware vCenter Inventory Service port is unreachable
  * **[HIGH]** => VMware vCenter Server port is unreachable
   **[HIGH]** => VMware vCenter Server service is down
  * **[HIGH]** => VMware vCenter Single Sign On service is down

Installation
------------

1. Import **zbx-vmware.xml** file into Zabbix.
2. Associate **ZBX-VMWARE-VCENTER** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
