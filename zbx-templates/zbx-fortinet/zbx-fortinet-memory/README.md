ZBX-FORTINET-MEMORY
===================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage Memory activity.

Items
-----

  * System Memory Capacity
  * System Memory Usage(%)
  * System Memory Usage
  * System Memory Usage(used-)
  * Low Memory Capacity
  * Low Memory Usage(%)
  * Low Memory Usage
  * Kernel Page Cache
  * Kernel Cache(Active)
  * Kernel Cache(Inactive)
  * Kernel Buffer
  * Kernel Conserve Enter Threshold
  * Kernel Conserve Leave Threshold
  * Proxy Conserve Enter Threshold
  * Proxy Conserve Leave Threshold

Triggers
--------

  * **[HIGH]** => Memory usage on device exceeded 80%
  * **[AVERAGE]** => Memory usage on device exceeded 70%
  * **[WARNING]** => Memory usage on device exceeded 60%
  * **[HIGH]** => Memory usage(used-) exceeded 50%

Graphs
------

  * Memory Usage

Installation
------------

1. Import **zbx-fortinet-memory.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-FORTINET-MEMORY** template to the host.
 
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
