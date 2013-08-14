ZBX-POWERWARE-UPS
=================

This template use the XUPS-MIB to discover and manage EATON POWERWARE UPS devices.

Items
-----

  * Contact (Populates host inventory field **Contact**)
  * Device Location (Populates host inventory field **Location**)
  * Device Manufacturer Name (Populates host inventory field **Tag**)
  * Device Name (Populates host inventory field **Name**)
  * Device reachability using ICMP
  * Battery test status
  * Battery status
  * Battery capacity
  * Battery time remaining
  * Battery voltage
  * Battery current
  * Output power source
  * Output frequency
  * Input source
  * Input frequency
  * Number of deviations from normal frequency or voltage
  * Alarm(s)

Triggers
--------

  * **[DISASTER]** => Input source failure
  * **[DISASTER]** => Device is UNREACHABLE or DOWN
  * **[DISASTER]** => Battery time remaining is CRITICAL
  * **[HIGH]** => On battery
  * **[HIGH]** => Battery test FAILED
  * **[HIGH]** => Battery time remaining is LOW
  * **[AVERAGE]** => On bypass
  * **[AVERAGE]** => Detected alarm(s)
  * **[AVERAGE]** => Battery is discharging
  * **[WARNING]** => On automatic bypass
  * **[INFORMATION]** => On manual bypass
  * **[INFORMATION]** => Device has just been restarted
  * **[INFORMATION]** => Hostname was changed

Graphs
------

  * Battery status
  * Battery capacity
  * Battery time remaining
  * Battery current
  * Number of deviations from normal frequency or voltage

Installation
------------

1. Add a value mapping named `xupsBatteryAbmStatus` with the following values:
  * 1 => Battery charging
  * 2 => Battery discharging
  * 3 => Battery floating
  * 4 => Battery resting
  * 5 => Unknown
2. Add a value mapping named `xupsInputSource` with the following values:
  * 1 => Other
  * 2 => None
  * 3 => Primary Utility
  * 4 => Bypass Feed
  * 5 => Secondary Utility
  * 6 => Generator
  * 7 => Fly wheel
  * 8 => Fuel cell
3. Add a value mapping named `xupsOutputSource` with the following values:
  * 1 => Other
  * 2 => None
  * 3 => Normal
  * 4 => Bypass
  * 5 => Battery
  * 6 => Booster
  * 7 => Reducer
  * 8 => Parallel capacity
  * 9 => Parallel redundant
  * 10 => High efficiency mode
  * 11 => Maintenance bypass
4. Add a value mapping named `xupsTestBatteryStatus` with the following values:
  * 1 => Unknown
  * 2 => Passed
  * 3 => Failed
  * 4 => In progress
  * 5 => Not supported
  * 6 => Inhibited
  * 7 => Scheduled
5. Import **zbx-powerware-ups.xml** file into Zabbix.
6. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
7. Configure **Host Inventory** to `Automatic` for your host.
8. Associate **ZBX-POWERWARE-UPS** template to the host.
 
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
