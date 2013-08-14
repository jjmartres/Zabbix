ZBX-DELL-POWERCONNECT-ENVMON
============================

This template use the DELL-ITA-MIB to discover and manage environmental of Dell devices.

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
  * Unused memory for the last 5 minutes
  * Uptime
  * Used CPU for the last 5 minutes
  * Available memory
  * Discovery: each fan name
  * Discovery: each fan state
  * Discovery: each power supply name
  * Discovery: each power supply state

Triggers
--------

  * **[DISASTER]** => Device is UNREACHABLE or DOWN
  * **[DISASTER]** => Discovery: each fan, operational status is SHUTDOWN
  * **[DISASTER]** => Discovery: each power supply, operational status is SHUTDOWN
  * **[HIGH]** => Device as just been restarted
  * **[HIGH]** => Memory usage on device exceeded 80%
  * **[HIGH]** => Discovery: each fan, operational status is NOT FUNCTIONNING
  * **[HIGH]** => Discovery: each power supply, operational status is NOT FUNCTIONNING
  * **[AVERAGE]** => Memory usage on device exceeded 70%
  * **[AVERAGE]** => Discovery: each fan, operational status is CRITICAL
  * **[AVERAGE]** => Discovery: each power supply, operational status is CRITICAL
  * **[WARNING]** => Memory usage on device exceeded 60%
  * **[WARNING]** => Discovery: each fan, operational status is WARNING
  * **[WARNING]** => Discovery: each power supply, operational status is WARNING
  * **[INFORMATION]** => Software version on device was changed
  * **[INFORMATION]** => Hostname was changed on device
  * **[INFORMATION]** => Discovery: each fan, operational status was changed
  * **[INFORMATION]** => Discovery: each power supply, operational status was changed

Graphs
------

  * Memory usage

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Add a value mapping named `dellEnvMonState` with the following values:
  * 1 => normal
  * 2 => warning
  * 3 => critical
  * 4 => shutdown
  * 5 => notPresent
  * 6 => notFunctioning
4. Import **zbx-dell-powerconnect-envmon.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Configure **Host Inventory** to `Automatic` for your host.
7. Associate **ZBX-DELL-POWERCONNECT-ENVMON** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0

This template use this script to echo "Dell Inc." as Device Manufacturer Name for **Host Inventory**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
