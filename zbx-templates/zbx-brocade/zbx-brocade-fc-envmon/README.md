ZBX-BROCADE-FC-ENVMON
=====================

This template use the SW-MIB and MIB-2 to discover and manage environmental of Brocade FC devices.

Items
-----

  * Contact (Populates host inventory field **Contact**)
  * Device Location (Populates host inventory field **Location**)
  * Device Manufacturer Name (Populates host inventory field **Tag**)
  * Device Mode Name (Populates host inventory field **Type**)
  * Device Name (Populates host inventory field **Name**)
  * Device reachability using ICMP
  * Device Serial Number (Populates host inventory field **Serial Number A**)
  * Fibre Channel domain ID
  * Fibre Channel logical switch ID
  * Fibre Channel management address
  * Fibre Channel principal switch indicator
  * FOS version (Populates host inventory field **OS**)
  * Uptime
  * Discovery: each fan state
  * Discovery: each fan speed
  * Discovery: each power supply state
  * Discovery: each temperature sensor state
  * Discovery: each temperature sensor value

Triggers
--------

  * **[DISASTER]** => Device is UNREACHABLE or DOWN
  * **[HIGH]** => Device as just been restarted
  * **[HIGH]** => Discovery: each fan, operational status is NOT NORMAL
  * **[HIGH]** => Discovery: each power supply, operational status is NOT NORMAL
  * **[HIGH]** => Discovery: each temperature sensor, operational status is NOT NORMAL
  * **[INFORMATION]** => FOS version on device was changed
  * **[INFORMATION]** => Hostname was changed on device
  * **[INFORMATION]** => Discovery: each fan, operational status was changed
  * **[INFORMATION]** => Discovery: each power supply, operational status was changed
  * **[INFORMATION]** => Discovery: each temperature sensor, operational status was changed

Graphs
------

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Add a value mapping named `swFcBoolean` with the following values:
  * 1 => yes
  * 2 => no
4. Add a value mapping named `swFcSensorStatus` with the following values:
  * 1 => unknown
  * 2 => faulty
  * 3 => below-mini
  * 4 => nominal
  * 5 => above-max
  * 6 => absent
5. Import **zbx-brocade-fc-envmon.xml** file into Zabbix.
6. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
7. Configure **Host Inventory** to `Automatic` for your host.
8. Associate **ZBX-BROCADE-FC-ENVMON** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0

This template use this script to echo "Cisco Systems" as Device Manufacturer Name for **Host Inventory**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
