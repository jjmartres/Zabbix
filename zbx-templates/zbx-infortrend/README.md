ZBX-IFT-SA
==========

This template use the IFT-SNMP-MIB to discover and manage INFORTREND Storage Array.

Items
-----

  * Contact (Populates host inventory field **Contact**)
  * Device Location (Populates host inventory field **Location**)
  * Device Manufacturer Name (Populates host inventory field **Tag**)
  * Device Name (Populates host inventory field **Name**)
  * Device Model Name (Populates host inventory field **Type**)
  * Device reachability using ICMP
  * Device Serial Number (Populates host inventory field **Serial Number A**)
  * Firmware major version (Populates host inventory field **OS**)
  * Firmware minor version
  * Uptime
  * Discovery: status for each device slot
  * Discovery: status for each fan
  * Discovery: status for each HDD
  * Discovery: serial number for each HDD
  * Discovery: revision number for each HDD
  * Discovery: size for each HDD
  * Discovery: model for each HDD
  * Discovery: associated logical drive for each HDD
  * Discovery: operating mode for each logical mode
  * Discovery: size of each logical drive
  * Discovery: status of each logical drive
  * Discovery: number of failed HDD for each logical drive
  * Discovery: number of online HDD for each logical drive
  * Discovery: number of spare HDD for each logical drive
  * Discovery: total number of HDD for each logical drive
  * Discovery: status for each power supply
  * Discovery: status for each temperature sensor

Triggers
--------

  * **[DISASTER]** => Storage Array is UNREACHABLE or DOWN
  * **[DISASTER]** => Discovery: HDD is FAILED
  * **[DISASTER]** => Discovery: Logical drive is DEAD
  * **[DISASTER]** => Discovery: COLD temperature limit EXCEEDED
  * **[HIGH]** => Storage Array has just been restarted
  * **[HIGH]** => Discovery: Device slot is MALFUNCTIONING on Storage Array
  * **[HIGH]** => Discovery: Fan is MALFUNCTIONING on Storage Array
  * **[HIGH]** => Discovery: HDD FAILED for Logical drive
  * **[HIGH]** => Discovery: Power Supply is MALFUNCTIONING
  * **[HIGH]** => Discovery: HOT temperature WARNING
  * **[HIGH]** => Discovery: temperature sensor is MALFUNCTIONING
  * **[AVERAGE]** => Discovery: HDD is NOT ONLINE
  * **[AVERAGE]** => Discovery: Logical drive is DEGRADED
  * **[AVERAGE]** => Discovery: COLD temperature WARNING
  * **[WARNING]** => Discovery: Logical drive is REBUILDING
  * **[INFORMATION]** => Hostname was changed on Storage Array
  * **[INFORMATION]** => Software version was changed on Storage Array
  * **[INFORMATION]** => Discovery: new HDD has been detected
  * **[INFORMATION]** => Discovery: Logical drive is INITIALIZING

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Install [`ift.ldmode`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/ift.ldmode) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
4. Then `chmod a+x ift.ldmode`
5. Install [`ift.ldstatus`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/ift.ldstatus) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
6. Then `chmod a+x ift.ldstatus`
5. Install [`ift.ldsize`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/ift.ldsize) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
6. Then `chmod a+x ift.ldsize`
7. Add a value mapping named `infortrendHddStatus` with the following values:
  * 0 => New Drive
  * 1 => On-Line Drive
  * 2 => Used Drive
  * 3 => Spare Drive
  * 4 => Drive Initialization in Progress
  * 5 => Drive Rebuild in Progress
  * 6 => Add to Logical Drive in Progress
  * 9 => Global Spare Drive
  * 17 => Drive is in process of Cloning another Drive
  * 18 => Drive is a valid Clone of another Drive
  * 19 => Drive is in process of Copying from another Drive
  * 63 => Drive is in process of Copying from another Drive
  * 128 => SCSI Device (Type 0)
  * 129 => SCSI Device (Type 1)
  * 130 => SCSI Device (Type 2)
  * 131 => SCSI Device (Type 3)
  * 132 => SCSI Device (Type 4)
  * 134 => SCSI Device (Type 5)
  * 135 => SCSI Device (Type 6)
  * 136 => SCSI Device (Type 7)
  * 137 => SCSI Device (Type 8)
  * 138 => SCSI Device (Type 9)
  * 139 => SCSI Device (Type 10)
  * 140 => SCSI Device (Type 11)
  * 141 => SCSI Device (Type 12)
  * 142 => SCSI Device (Type 13)
  * 143 => SCSI Device (Type 14)
  * 252 => Missing Global Spare Drive
  * 253 => Missing Spare Drive
  * 254 => Missing Drive
  * 255 => Failed Drive
8. Add a value mapping named `infortrendLdOpMode` with the following values:
  * 0 => Single Drive
  * 1 => Non Raid
  * 10 => RAID 0
  * 11 => RAID 1
  * 100 => RAID 3
  * 101 => RAID 4
  * 110 => RAID 5
  * 111 => RAID 6
9. Add a value mapping named `infortrendLdStatus` with the following values:
  * 0 => GOOD
  * 1 => REBUILDING
  * 10 => INITILAIZING
  * 11 => DEGRADEED
  * 100 => DEAD
  * 101 => INVALID
  * 110 => INCOMPLETE
  * 111 => DRIVE MISSING
10. Add a value mapping named `infortrendLuDevStatus` with the following values:
  * 0 => Functioning Normally
  * 1 => Malfunctioning
  * 2 => Cold Temp. Warning
  * 3 => Hot Temp. Warning
  * 4 => Cold Temp. Limit Exceeded
11. Import **zbx-ift-sa.xml** file into Zabbix.
12. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
13. Configure **Host Inventory** to `Automatic` for your host.
14. Associate **ZBX-IFT-SA** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0

This template use this script to echo "Infortrend" as Device Manufacturer Name for **Host Inventory**.

###### [ift.ldmode](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/ift.ldmode) 1.0

This template use this script to get operational mode for each logical drive.

###### [ift.ldstatus](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/ift.ldstatus) 1.0

This template use this script to get the status of each logical drive.

###### [ift.ldsize](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/ift.ldsize) 1.0

This template use this script to get the size of each logical drive.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
