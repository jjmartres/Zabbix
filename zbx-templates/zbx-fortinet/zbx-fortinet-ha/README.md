ZBX-FORTINET-HA
===============

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage High Availability.

Items
-----

  * Configuration of automatic synchronization
  * High availability cluster group name
  * High availability cluster priority
  * High availability  mode
  * Load-balancing schedule of cluster
  * Status of a master override flag
  * Discovery: CPU usage for each cluster unit
  * Discovery: current session count for each cluster unit
  * Discovery: memory usage for each cluster unit
  * Discovery: network bandwidth usage for each cluster unit
  * Discovery: number of anti-virus events triggered for each cluster unit
  * Discovery: number of IDS/IPS events triggered for each cluster unit

Triggers
--------

  * **[HIGH]** => Memory usage for each unit exceeded 80%
  * **[HIGH]** => CPU usage for each unit exceeded 80%
  * **[HIGH]** => An increase of 40% of active sessions for each unit was detected
  * **[AVERAGE]** => Memory usage for each unit exceeded 70%
  * **[AVERAGE]** => CPU usage for each unit exceeded 60%
  * **[AVERAGE]** => An increase of 30% of active sessions for each unit was detected
  * **[WARNING]** => Memory usage for each unit exceeded 60%
  * **[WARNING]** => CPU usage for each unit exceeded 50%
  * **[WARNING]** => An increase of 20% of active sessions for each unit was detected

Graphs
------

  * Discovery: CPU usage for each cluster unit
  * Discovery: Memory usage for each cluster unit
  * Discovery: Network bandwidth for each cluster unit
  * Discovery: Sessions count for each cluster unit

Installation
------------

1. Add a value mapping named `FgBoolState` with the following values:
  * 1 => disabled
  * 2 => enabled
2. Add a value mapping named `FgHaLbSchedule` with the following values:
  * 1 => none
  * 2 => hub
  * 3 => leastConnections
  * 4 => roundRobin
  * 5 => weightedRoundRobin
  * 6 => random
  * 7 => ipBased
  * 8 => ipPortBased
3. Add a value mapping named `FgHaMode` with the following values:
  * 1 => standalone
  * 2 => activeActive
  * 3 => activePassive
4. Import **zbx-fortinet-ha.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-FORTINET-HA** template to the host.

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
