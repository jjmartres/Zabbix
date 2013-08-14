ZBX-NETOPIA-ENVMON
==================

This template use the NETOPIA-MIB to discover and manage environmental of Netopia devices.

Items
-----

  * Contact (Populates host inventory field **Contact**)
  * Device Location (Populates host inventory field **Location**)
  * Device Manufacturer Name (Populates host inventory field **Tag**)
  * Device Name (Populates host inventory field **Name**)
  * Device reachability using ICMP
  * Device Serail Number (Populates host inventory field **Serial Number A**)
  * Software Version (Populates host inventory field **OS**)
  * Software Version (full) (Populates host inventory field **OS (Full details)**)
  * Total memory
  * Uptime
  * Used CPU for the last 5 minutes
  * Used memory

Triggers
--------

  * **[DISASTER]** => Device is UNREACHABLE or DOWN
  * **[HIGH]** => Device as just been restarted
  * **[HIGH]** => Memory usage on device exceeded 80%
  * **[HIGH]** => CPU usage on device exceeded 80%
  * **[AVERAGE]** => Memory usage on device exceeded 70%
  * **[AVERAGE]** => CPU usage on device exceeded 60%
  * **[WARNING]** => Memory usage on device exceeded 60%
  * **[WARNING]** => CPU usage on device exceeded 50%
  * **[INFORMATION]** => Software version on device was changed
  * **[INFORMATION]** => Hostname was changed on device

Graphs
------

  * CPU usage
  * Memory usage

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Import **zbx-netopia-envmon.xml** file into Zabbix.
4. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
5. Configure **Host Inventory** to `Automatic` for your host.
6. Associate **ZBX-NETOPIA-ENVMON** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0

This template use this script to echo "Netopia" as Device Manufacturer Name for **Host Inventory**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
