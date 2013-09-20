ZBX-FORTINET-CPU
===================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage CPU activity.

Items
-----

  * CPU Usage
  * Number of Processors
  * Discovery: Average Usage over 5sec per a particular processor
  * Discovery: Average Usage over 1min per a particular processor
  * Discovery: Average Usage of User Process over 1min per a particular processor
  * Discovery: Average Usage of System Process over 1min per a particular processor

Triggers
--------

  * **[HIGH]** => CPU usage on device exceeded 80%
  * **[AVERAGE]** => CPU usage on device exceeded 60%
  * **[WARNING]** => CPU usage on device exceeded 50%
  * **[HIGH]** => Average Usage over 5sec per a particular processor exceeded 80%

Graphs
------

  * CPU Usage
  * CPU Usage per a particular processor

Installation
------------

1. Import **zbx-fortinet-cpu.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-FORTINET-CPU** template to the host.
 
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
