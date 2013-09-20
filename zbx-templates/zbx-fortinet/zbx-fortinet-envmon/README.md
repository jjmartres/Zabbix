ZBX-FORTINET-ENVMON
===================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage environmental of Fortinet devices.

Items
-----

  * Contact (Populates host inventory field **Contact**)
  * Device Location (Populates host inventory field **Location**)
  * Device Manufacturer Name (Populates host inventory field **Tag**)
  * Device Name (Populates host inventory field **Name**)
  * Device reachability using ICMP
  * Device Serial Number (Populates host inventory field **Serial Number A**)
  * FortiOS Version (Populates host inventory field **OS**)
  * Uptime
  * Disk Usage
  * IPS signature database version
  * Virus signature database version

Triggers
--------

  * **[DISASTER]** => Device is UNREACHABLE or DOWN
  * **[HIGH]** => Device as just been restarted
  * **[INFORMATION]** => Software version on device was changed
  * **[INFORMATION]** => Hostname was changed on device
  * **[INFORMATION]** => IPS signature database was changed
  * **[INFORMATION]** => Virus signature database was changed
  * **[INFORMATION]** => Device Serial Number was changed

Graphs
------

  * Disk Usage

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Import **zbx-fortinet-envmon.xml** file into Zabbix.
4. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
5. Configure **Host Inventory** to `Automatic` for your host.
6. Associate **ZBX-FORTINET-ENVMON** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0

This template use this script to echo "Fortinet" as Device Manufacturer Name for **Host Inventory**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
