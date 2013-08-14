ZBX-LINUX-ENVMON
================

This template use Zabbix agent to discover and manage environmental informations of Linux based server.

Items
-----

  * System uptime
  * System local time
  * System boot time
  * System detailed information (Populates **OS** inventory field Tag)
  * Host reachability using ICMP
  * Host packet loss
  * Host name
  * Host primary role (Populates **Tag** inventory field Tag)
  * Host name (Populates **Name** inventory field Tag)
  * Host material (Populates **Type** inventory field Tag)
  * Host location (Populates **Location** inventory field Tag)
  * Server configured domain
  * Check name resolution
  * Available memory
  * Total memory
  * Free swap space
  * Free swap space in %
  * Total swap space
  * Checksum of /etc/passwd
  * Context switches per second
  * CPU steal time
  * CPU system time
  * CPU user time
  * CPU softirq time
  * CPU idle time
  * CPU interrupt time
  * CPU iowait time
  * CPU nice time
  * CPU load (1 min average per core)
  * CPU load (5 min average per core)
  * CPU load (15 min average per core)
  * Interrupts per second
  * Maximum number of opened files
  * Maximum number of processes
  * Number of logged in users
  * Number of processes
  * Check the Zabbix agent availability
  * Zabbix agent configured hostname
  * Version of Zabbix agent
  * Discovery: free disk space (percentage) for each mounted filesystem
  * Discovery: used disk space on each mounted filesystem
  * Discovery: total disk space on each mounted filesystem
  * Discovery: free inodes (percentage) on each mounted filesystem
  * Discovery: free disk space on each mounted filesystem
  * Discovery: incoming traffic on each interface
  * Discovery: outgoing traffic on each interface
  * Discovery: incoming dropped packets on each interface
  * Discovery: outgoing dropped packets on each interface
  * Discovery: incoming errors on each interface
  * Discovery: outgoing errors on each interface
  * Discovery: process running


Triggers
--------

  * **[DISASTER]** => Host is UNREACHABLE or DOWN
  * **[HIGH]** => Disk I/O is overloaded
  * **[HIGH]** => DNS resolution failed
  * **[HIGH]** => Discovery: free disk space is less than {$DISK\_THRESHOLD\_HIGH}% on each mounted filesystem
  * **[HIGH]** => Discovery: process not running
  * **[AVERAGE]** => Too many processes. Value is greater than macro {$PROCESS\_THRESHOLD\_MAX}
  * **[AVERAGE]** => Lack of available memory on server
  * **[AVERAGE]** => Zabbix agent is unreachable for 5 minutes
  * **[AVERAGE]** => IP packet loss detected
  * **[AVERAGE]** => Lack of free swap space. Value is lower than macro {$FREESWAP\_THRESHOLD\_WARN}
  * **[AVERAGE]** => Discovery: incoming errors on each interface
  * **[AVERAGE]** => Discovery: outgoing errors on each interface
  * **[AVERAGE]** => Discovery: incoming dropped packets on each interface
  * **[AVERAGE]** => Discovery: outgoing dropped packets on each interface
  * **[WARNING]** => /etc/passwd has been changed
  * **[WARNING]** => CPU load is too high
  * **[WARNING]** => Discovery: Free disk space is less than {$DISK\_THRESHOLD\_WARN}% on each mounted filesystem
  * **[WARNING]** => Discovery: Free inodes is less tahn 20% on each mounted filesystem
  * **[INFORMATION]** => Host has just been restarted
  * **[INFORMATION]** => Host information was changed
  * **[INFORMATION]** => Configured max number of processes is too low
  * **[INFORMATION]** => Version of zabbix_agent(d) was changed
  * **[INFORMATION]** => Hostname was changed
  * **[INFORMATION]** => Configured max number of opened files is too low


Graphs
------

  * CPU jumps
  * CPU load
  * CPU utilization
  * Swap usage
  * Discovery: disk space usage for each mounted filesystem
  * Discovery: traffic (bits/sec, 95th Percentile) for each interface
  * Discovery: errors on each interface

Macros
------

  * **{$HOST_LOCATION}** => User defined host location
  * **{$HOST_MATERIAL}** => User defined host material (for example physical or virtual)
  * **{$HOST_ROLE}** => User defined server role
  * **{$CPU\_THRESHOLD\_WARN}** => Warning threshold value for CPU usage. Default value is 60 (percent).
  * **{$CPU\_THRESHOLD\_HIGH}** => High threshold value for CPU usage. Default value is 90 (percent).
  * **{$DISK\_THRESHOLD\_WARN}** => Warning threshold value for disk usage. Default value is 20 (percent).
  * **{$DISK\_THRESHOLD\_HIGH}** => High threshold value for disk usage. Default value is 10 (percent).
  * **{$FREESWAP\_THRESHOLD\_WARN}** => Minimum free swap value. Default value is 50 (percent).
  * **{$PROCESS\_THRESHOLD\_MAX}** = Threshold value for max process. Default value is 400.

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Add a value mapping named `Zabbix agent failed/successful status` with the following values:
  * 0 => failed
  * 1 => successful
4. Under the `/etc/zabbix` directory create a file called `proc.num.list` which contained a list of important processes you want to monitor. File structure is like this :
  {
    "data":[
    { "{#PSBIN}":"sshd",                          "{#PSNAME}":"SSH"   },
    { "{#PSBIN}":"vmtoolsd",                      "{#PSNAME}":"vmWARE Tools"    }
    ]
  }
5. Install the Zabbix agent on your host

  1. Add the following line to your Zabbix agent configuration file. Note that `<zabbix_script_path>` is your Zabbix agent script path :

    EnableRemoteCommands=1
    UserParameter= proc.discovery, cat /etc/zabbix/proc.num.list

6. Import **zbx-linux-envmon.xml** file into Zabbix.
7. Add to your host the followed macro with value
  1. **{$HOST_LOCATION}**
  2. **{$HOST_MATERIAL}**
  3. **{$HOST_ROLE}**
8. Associate **ZBX-LINUX-ENVMON** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

##### [Zabbix agent](http://www.zabbix.com) 2.0.x
##### [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) 1.0
This template use this script to echo user defined macros for **Host Inventory**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
