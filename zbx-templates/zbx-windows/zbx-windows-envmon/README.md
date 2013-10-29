ZBX-WINDOWS-ENVMON
==================

This template use Zabbix agent to discover and manage environmental informations of Windows based server.

Items
-----

  * System uptime
  * System local time
  * System boot time
  * System detailed information (Populates **OS** inventory field Tag)
  * System serial number (Populates **Serial number A** inventory field Tag)
  * Windows server roles (Populates **OS (Full details)** inventory field Tag)
  * Netbios name
  * Host reachability using ICMP
  * Host packet loss
  * Host primary role (Populates **Tag** inventory field Tag)
  * Host name (Populates **Name** inventory field Tag)
  * Host material (Populates **Type** inventory field Tag)
  * Host location (Populates **Location** inventory field Tag)
  * Server configured domain
  * Check name resolution
  * Free memory
  * Free swap space
  * Total swap space
  * Total memory
  * Available critical Windows updates
  * Available Windows updates
  * Average disk read queue length
  * Average disk write queue length
  * CPU usage
  * File read bytes per second
  * File write bytes per second
  * Number of processes
  * Number of threads
  * Check the Zabbix agent availability
  * Zabbix agent configured hostname
  * Version of Zabbix agent
  * Application warning, error or failure messages from eventlog (Zabbix agent active check)
  * DFS Replication warning, error or failure messages from eventlog (Zabbix agent active check)
  * Directory service warning, error or failure messages from eventlog (Zabbix agent active check)
  * DNS server warning, error or failure messages from eventlog (Zabbix agent active check)
  * File replication service warning, error or failure messages from eventlog (Zabbix agent active check)
  * Security warning, error or failure messages from eventlog (Zabbix agent active check)
  * System warning, error or failure messages from eventlog (Zabbix agent active check)
  * Discovery: state for automatic startup services
  * Discovery: disk quota bytes free
  * Discovery: disk quota bytes limit
  * Discovery: disk quota bytes used
  * Discovery: incoming traffic on each interface
  * Discovery: outgoing traffic on each interface
  * Discovery: incoming errors on each interface
  * Discovery: outgoing errors on each interface
  * Discovery: incoming dropped packets on each interface
  * Discovery: outgoing dropped packets on each interface
  * Discovery: Disk transfert/s (IOPS) for each disk
  * Discovery: Disk idle time for each disk
  * Discovery: Used disk space for each disk
  * Discovery: Total disk space for each disk
  * Discovery: Free disk space (percentage) for each disk
  * Discovery: Free disk space for each disk

Triggers
--------

  * **[DISASTER]** => Host is UNREACHABLE or DOWN
  * **[DISASTER]** => Discovery: Free disk space is less than {$DISK\_THRESHOLD\_DISASTER}% on each disk
  * **[HIGH]** => Application audit failure message(s) logged in eventlog
  * **[HIGH]** => DNS resolution failed
  * **[HIGH]** => CPU usage exceeded {$CPU\_THRESHOLD\_HIGH}%
  * **[HIGH]** => System audit failure message(s) logged in eventlog
  * **[HIGH]** => Directory service audit failure message(s) logged in eventlog
  * **[HIGH]** => IP packet loss detected
  * **[HIGH]** => File Replication Service audit failure message(s) logged in eventlog
  * **[HIGH]** => Security audit failure message(s) logged in eventlog
  * **[HIGH]** => Critical audit failure message(s) logged in eventlog
  * **[HIGH]** => Host as just been restarted
  * **[HIGH]** => DNS server audit failure message(s) logged in eventlog
  * **[HIGH]** => Discovery: service is not running
  * **[HIGH]** => Discovery: quota bytes free depleted. Value is under macro {$QUOTA\_THRESHOLD\_DEPL}
  * **[HIGH]** => Discovery: Free disk space is less than {$DISK\_THRESHOLD\_HIGH}% on each disk
  * **[HIGH]** => Discovery: Too many disk transfert/s (IOPS) detected on each disk
  * **[AVERAGE]** => Lack of free memory
  * **[AVERAGE]** => Lack of free swap space
  * **[AVERAGE]** => Zabbix agent is unreachable for 5 minutes
  * **[AVERAGE]** => Host information was changed
  * **[AVERAGE]** => Too many processes. Value is greater than macro {$PROCESS\_THRESHOLD\_MAX}
  * **[AVERAGE]** => Application error message(s) logged in eventlog
  * **[AVERAGE]** => Directory service error message(s) logged in eventlog
  * **[AVERAGE]** => System error message(s) logged in eventlog
  * **[AVERAGE]** => Security error message(s) logged in eventlog
  * **[AVERAGE]** => DNS Server error message(s) logged in eventlog
  * **[AVERAGE]** => File Replication Service error message(s) logged in eventlog
  * **[AVERAGE]** => Discovery: quota bytes free critical. Value is under macro {$QUOTA\_THRESHOLD\_CRIT}
  * **[AVERAGE]** => Discovery: incoming errors detected on each interface
  * **[AVERAGE]** => Discovery: outgoing errors detected on each interface
  * **[AVERAGE]** => Discovery: incoming dropped packets detected on each interface
  * **[AVERAGE]** => Discovery: outgoing dropped packets detected on each interface
  * **[WARNING]** => DNS Server warning message(s) logged in eventlog
  * **[WARNING]** => File Replication Service warning message(s) logged in eventlog
  * **[WARNING]** => Directory service warning message(s) logged in eventlog
  * **[WARNING]** => Application warning message(s) logged in eventlog
  * **[WARNING]** => Security warning message(s) logged in eventlog
  * **[WARNING]** => System warning message(s) logged in eventlog
  * **[WARNING]** => CPU usage exceeded {$CPU\_THRESHOLD\_WARN}%
  * **[WARNING]** => Discovery: quota bytes free low. Value is under macro {$QUOTA\_THRESHOLD\_LOW}
  * **[WARNING]** => Discovery: Free disk space is less than {$DISK\_THRESHOLD\_WARN}% on each disk
  * **[INFORMATION]** => Host name of zabbix_agentd was changed
  * **[INFORMATION]** => Windows updates available
  * **[INFORMATION]** => Version of zabbix_agent(d) was changed

Graphs
------

  * CPU load
  * Discovery: quota bytes free
  * Discovery: disk space usage for each disk
  * Discovery: disk transfert/s (IOPS) for each disk
  * Discovery: traffic (bits/sec, 95th Percentile) for an interface
  * Discovery: errors on an interface

Macros
------

  * **{$HOST_LOCATION}** => User defined host location
  * **{$HOST_MATERIAL}** => User defined host material (for example physical or virtual)
  * **{$HOST_ROLE}** => User defined server role
  * **{$CPU\_THRESHOLD\_WARN}** => Warning threshold value for CPU usage. Default value is 60 (percent).
  * **{$CPU\_THRESHOLD\_HIGH}** => High threshold value for CPU usage. Default value is 90 (percent).
  * **{$DISK\_THRESHOLD\_DISASTER}** => Disaster threshold value for disk usage. Default value is 4 (percent).
  * **{$DISK\_THRESHOLD\_WARN}** => Warning threshold value for disk usage. Default value is 20 (percent).
  * **{$DISK\_THRESHOLD\_HIGH}** => High threshold value for disk usage. Default value is 10 (percent).
  * **{$QUOTA\_THRESHOLD\_CRIT}** => Critical threshold value for quota usage. Default value is 2147483648 (Bytes), 2GB.
  * **{$QUOTA\_THRESHOLD\_DEPL}** = Depleted threshold value for quota usage. Default value is 524288000 (Bytes), 500MB.
  * **{$QUOTA\_THRESHOLD\_LOW}** = Low threshold value for quota usage. Default value is 5368709120 (Bytes), 5GB.
  * **{$PROCESS\_THRESHOLD\_MAX}** = Threshold value for max process. Default value is 300.

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Add a value mapping named `Zabbix agent failed/successful status` with the following values:
  * 0 => failed
  * 1 => successful
4. Install the Zabbix agent on your host or download my automated package [`Zabbix agent`](https://github.com/jjmartres/Zabbix/tree/master/zbx-agent)

  If your choose to install the Zabbix agent from the source, you need to :
  1. Install [`zabbix_server_dns_config.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_server_dns_config.vbs) in the script directory of your Zabbix agent.
  2. Install [`zabbix_server_role.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_server_role.vbs) in the script directory of your Zabbix agent.
  3. Install [`zabbix_server_serialnumber.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_server_serialnumber.vbs) in the script directory of your Zabbix agent.
  4. Install [`zabbix_user_domain.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_user_domain.vbs) in the script directory of your Zabbix agent.
  5. Install [`zabbix_win_quota.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_win_quota.vbs) in the script directory of your Zabbix agent.
  6. Install [`zabbix_win_system_discovery.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_win_system_discovery.vbs) in the script directory of your Zabbix agent.
  7. Install [`zabbix_wus_update_all.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_wus_update_all.vbs) in the script directory of your Zabbix agent.
  8. Install [`zabbix_wus_update_crit.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_wus_update_crit.vbs) in the script directory of your Zabbix agent.
  9. Add the following line to your Zabbix agent configuration file. Note that `<zabbix_script_path>` is your Zabbix agent script path :

      EnableRemoteCommands=1
      UnsafeUserParameters=1
      UserParameter = system.discovery[*],%systemroot%\system32\cscript.exe /nologo /T:30 <zabbix_script_path>\zabbix_win_system_discovery.vbs $1
      UserParameter = quota[*],%systemroot%\system32\cscript.exe /nologo /T:30 <zabbix_script_path>\zabbix_win_quota.vbs $1 $2
      UserParameter = wu.all,%systemroot%\system32\cscript.exe /nologo /T:30  <zabbix_script_path>\zabbix_wus_update_all.vbs
      UserParameter = wu.crit,%systemroot%\system32\cscript.exe /nologo /T:30  <zabbix_script_path>\zabbix_wus_update_crit.vbs
      UserParameter = server.domain,%systemroot%\system32\cscript.exe /nologo /T:30  <zabbix_script_path>\zabbix_user_domain.vbs
      UserParameter = server.roles,%systemroot%\system32\cscript.exe /nologo /T:30  <zabbix_script_path>\zabbix_server_role.vbs
      UserParameter = server.serial,%systemroot%\system32\cscript.exe /nologo /T:30  <zabbix_script_path>\zabbix_server_serialnumber.vbs

5. Import **zbx-windows-envmon.xml** file into Zabbix.
6. Add to your host the followed macro with value
  1. **{$HOST_LOCATION}**
  2. **{$HOST_MATERIAL}**
  3. **{$HOST_ROLE}**
7. Associate **ZBX-WINDOWS-ENVMON** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

##### [Zabbix agent](http://www.zabbix.com) 2.0.x
##### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0
This template use this script to echo user defined macros for **Host Inventory**.
##### [zabbix\_server\_dns\_config.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_server_dns_config.vbs) 1.0
##### [zabbix\_server\_role.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_server_role.vbs) 1.0
##### [zabbix\_server\_serialnumber.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_server_serialnumber.vbs) 1.0
##### [zabbix\_user\_domain.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_user_domain.vbs) 1.0
##### [zabbix\_win\_quota.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_win_quota.vbs) 1.0
##### [zabbix\_win\_system\_discovery.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_win_system_discovery.vbs) 1.0
##### [zabbix\_wus\_update\_all.vbs](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_wus_update_all.vbs) 1.0
##### [zabbix\_wus\_update\_crit.vbs`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-windows/zbx-windows-envmon/zabbix_wus_update_crit.vbs) 1.0

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
