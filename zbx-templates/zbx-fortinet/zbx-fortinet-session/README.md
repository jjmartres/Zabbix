ZBX-FORTINET-SESSION
===================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage firewall session activity.

Items
-----

  * IPv4 Active sessions
  * IPv4 Session Setup Rate over 1 min
  * IPv4 Session Setup Rate over 10 mins
  * IPv4 Session Setup Rate over 30 mins
  * IPv4 Session Setup Rate over 60 mins
  * IPv6 Active sessions
  * IPv6 Session Setup Rate over 1 min
  * IPv6 Session Setup Rate over 10 mins
  * IPv6 Session Setup Rate over 30 mins
  * IPv6 Session Setup Rate over 60 mins
  * Ephemeral sessions: current number
  * Ephemeral sessions: limit number
  * Number of new sessions which have collision
  * Number of current expectation sessions
  * Counts of sync queue full
  * Counts of accept queue full
  * Counts of direct requests to FortiGate local stack

Triggers
--------

  * **[HIGH]** => An increase of 30% of ipv4 active sessions was detected
  * **[AVERAGE]** => An increase of 20% of ipv4 active sessions was detected
  * **[DISASTER]** => An increase of 40% of ipv4 active sessions was detected
  * **[HIGH]** => An increase of 30% of ipv6 active sessions was detected
  * **[AVERAGE]** => An increase of 20% ipv6 of active sessions was detected
  * **[DISASTER]** => An increase of 40% ipv6 of active sessions was detected
  * **[AVERAGE]** => Number of ephemeral sessions exceeded the limit

Graphs
------

  * Active Sessions

Installation
------------

1. Import **zbx-fortinet-session.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-FORTINET-SESSION** template to the host.
 
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
