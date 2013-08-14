ZBX-DATACORE-SSV
================

This template use the SANsymphony-V Cmdlets to discover and manage DataCore SANsymphony-V server.

Items
-----

  * Zabbix agent status on DataCore console server
  * Zabbix agent version on DataCore console server
  * Number of process on DataCore console server
  * Processor load (15min average) on DataCore console server
  * Processor load (5min average) on DataCore console server
  * Processor load (1min average) on DataCore console server
  * Discovery: free disk space on DataCore console server
  * Discovery: total disk space on DataCore console server
  * Discovery: used disk space on DataCore console server
  * DataCore server name
  * DataCore server state
  * DataCore server power state
  * DataCore executive service status
  * DataCore diagnostic mode
  * Served virtual disk
  * DataCore product name
  * Storage used
  * DataCore server log status
  * Total system memory
  * Available system memory
  * DataCore server cache size
  * DataCore server free cache size
  * DataCore server cache state
  * Log message of Information type
  * Log message of Trace type
  * Log message of Waring type
  * Log message of Error type
  * Log message of Diagnostic type
  * Discovery: virtual disk mirror status
  * Discovery: virtual disk served status
  * Discovery: virtual disk size
  * Discovery: virtual disk status
  * Discovery: pool disk allocated space
  * Discovery: pool disk available space
  * Discovery: pool disk in reclamation space
  * Discovery: pool disk max tier number support
  * Discovery: pool disk over subscribed space
  * Discovery: pool disk presence status
  * Discovery: pool disk status
  * Discovery: physical disk bus type
  * Discovery: physical disk type
  * Discovery: physical disk size
  * Discovery: physical disk status
  * Discovery: physical disk tier
  * Discovery: free space for physical disk
  * Discovery: pending operations on physical disk
  * Discovery: read operations on physical disk
  * Discovery: write operations on physical disk
  * Discovery: associated address on SCSI port  
  * Discovery: connected status on SCSI port
  * Discovery: role capabilities for SCSI port
  * Discovery: SCSI port type
  * Discovery: initiator pending operations on SCSI port
  * Discovery: initiator read operations SCSI port
  * Discovery: initiator write operations SCSI port
  * Discovery: target pending operations on SCSI port
  * Discovery: target read operations SCSI port
  * Discovery: target write operations SCSI port

Triggers
--------

  * **[DISASTER]** => DataCore executive service is not RUNNING
  * **[DISASTER]** => DataCore server state is NOT ONLINE
  * **[DISASTER]** => DataCore server power state is OFFLINE
  * **[DISASTER]** => Discovery: mirrored virtual disk is in DOUBLE FAILURE
  * **[DISASTER]** => Discovery: pool disk missed disk
  * **[DISASTER]** => Discovery: pool disk is OFFLINE
  * **[DISASTER]** => Discovery: physical disk is NOT ONLINE
  * **[HIGH]** => DataCore server power state is BatteryLow
  * **[HIGH]** => Message of level ERROR logged
  * **[HIGH]** => Discovery: virtual disk is  NOT ONLINE
  * **[HIGH]** => Discovery: virtual disk is in LOG RECOVERY
  * **[HIGH]** => Discovery: virtual disk is in FULL RECOVERY
  * **[HIGH]** => Discovery: virtual disk has FULL RECOVERY PENDING
  * **[HIGH]** => Discovery: virtual disk need FULL RECOVERY
  * **[HIGH]** => Discovery: pool disk has less than 10% of available space
  * **[HIGH]** => Discovery: pool disk has over subscribed space
  * **[HIGH]** => Discovery: SCSI port is NOT CONNECTED
  * **[AVERAGE]** => DataCore server log status is NOT OPERATIONAL
  * **[AVERAGE]** => DataCore server cache state was changed
  * **[AVERAGE]** => Discovery: virtual disk has LOG RECOVERY PENDING
  * **[AVERAGE]** => Discovery: virtual disk need LOG RECOVERY
  * **[AVERAGE]** => Discovery: pool disk need space reclamation
  * **[AVERAGE]** => Discovery: pool disk has less than 20% of available space
  * **[AVERAGE]** => Discovery: pending operations detected on physical disk
  * **[WARNING]** => DataCore diagnostic mode was changed
  * **[WARNING]** => Messsage of level WARNING logged
  * **[WARNING]** => Discovery: pool disk has less than 30% of available space
  * **[WARNING]** => Discovery: pool disk is INITIALIZING
  * **[INFORMATION]** => DataCore server name was changed
  * **[INFORMATION]** => Message of level DIAGNOSTIC logged
  * **[INFORMATION]** => Message of level INFORMATION logged
  * **[INFORMATION]** => Message of level TRACE logged
  * **[INFORMATION]** => Discovery: virtual disk served status was changed
  * **[INFORMATION]** => Discovery: role capability on SCSI port was changed

Graphs
------

  * Storage used
  * Served virtual disk
  * Message logged
  * DataCore server cache
  * Discovery: disk space usage on DataCore console server
  * Discovery: virtual disk size
  * Discovery: pool disk space
  * Discovery: physical disk space
  * Discovery: physical disk operations
  * Discovery: operations on SCSI port

Installation
------------

1. Install [`Zabbix Agent`](http://www.zabbix.com/downloads/2.0.4/zabbix_agents_2.0.7.win.zip) on both DataCore server
2. Install all `*.ps1` files to the Zabbix Agent script directory on both DataCore server
3. Install [`zbx-dcs.conf`](https://github.com/jjmartres/Zabbix/blob/master/zbx-templates/zbx-datacore/zbx-dcs.conf) to the Zabbix Agent config directory on both DataCore server
4. Add the following line to your Zabbix Agent configuration on both DataCore server
  * `Include=C:\Program Files\Zabbix\etc\zbx-dcs.conf`
5. Import **zbx-datacore-ssv.xml** file into Zabbix.
6. Create your host and use the DataCore console IP address as host IP address. If you don't have a console server, use the Datacore server IP address.
7. Add to your host the **{$DCS_USER}** macro with your DataCore server username as value.
8. Add to your host the **{$DCS_PASSWORD}** macro with your DataCore server password as value.
9. Add to your host the **{$DCS_IPADDR}** macro with your DataCore server IP address.
10. Associate **ZBX-DATACORE-SSV** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

As mentionned by DataCore on [`FAQ1348`](http://datacore.custhelp.com/app/answers/detail/a_id/1348), it is not recommended to run monitoring scripts directly on a production server to prevent unwanted CPU load. This template is created to be deployed on a console management server (a Windows server with SANsymphony-V Cmdlets installed), but can also be used directly on a production server.

###### [DataCore SANsymphony-V Cmdlets](http://www.datacore.com/SSV-Webhelp/Getting_Started_with_SANsymphony-V_Cmdlets.htm) 9.0 or higher

This template use the SANsymphony-V Cmdlets to discover and manage DataCore SANsymphony-V server.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
