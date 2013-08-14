ZBX-APC-UPS
===========

This template use the APC-POWERNET-MIB to discover and manage APC UPS devices.

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
  * UPS battery capacity
  * UPS battery status
  * UPS battery temperature
  * UPS current load
  * UPS input voltage
  * UPS output frequency
  * UPS output load
  * UPS output voltage
  * UPS replace battery indicator
  * UPS run time remaining
  * UPS status
  * UPS time on battery
  * Uptime

Triggers
--------

  * **[DISASTER]** => Run time remaining critical level
  * **[DISASTER]** => Replace battery
  * **[DISASTER]** => High battery temperature
  * **[DISASTER]** => Output load too high
  * **[DISASTER]** => Loss of input power
  * **[HIGH]** => Run time remaining low
  * **[WARNING]** => Output load too high

Graphs
------

  * Battery status
  * UPS load
  * UPS temperature
  * UPS voltage

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Add a value mapping named `apcBatteryStatus` with the following values:
  * 1 => unknown
  * 2 => batteryNormal
  * 3 => batteryLow
4. Add a value mapping named `apcBatteryReplacementStatus` with the following values:
  * 1 => unknown
  * 2 => notInstalled
  * 3 => ok
  * 4 => failed
  * 5 => highTemperature
  * 6 => replaceImmediately
  * 7 => lowCapacity
5. Add a value mapping named `apcStatus`with the following values:
  * 1 => unknown
  * 2 => onLine
  * 3 => onBattery
  * 4 => onSmartBoost
  * 5 => timedSleeping
  * 6 => softwareBypass
  * 7 => off
  * 8 => rebooting
  * 9 => switchedBypass
  * 10 => hardwareFailureBypass
  * 11 => sleepingUntilPowerReturn
  * 12 => onSmartTrim
4. Import **zbx-apc-ups.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Configure **Host Inventory** to `Automatic` for your host.
7. Associate **ZBX-APC-UPS** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0

This template use this script to echo "APC" as Device Manufacturer Name for **Host Inventory**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
