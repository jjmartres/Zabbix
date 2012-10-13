ZBX-CISCO-BGP4
==============

This template use the BGP4-MIB to discover and manage both IPv4 and VPNv4 neighbors on Cisco devices.

Triggers
--------

  * **[HIGH]** => BGP peer is down
  * **[AVERAGE]** => Accepted prefixes for IPv4 as reached the maximum limit
  * **[AVERAGE]** => Accepted prefixes for VPNv4 as reached the maximum limit
  * **[AVERAGE]** => IPv4 BGP peer has lost more than 20% of prefixes
  * **[AVERAGE]** => VPNv4 BGP peer has lost more than 20% of prefixes
  * **[INFORMATION]** => No prefixes receive for IPv4 peer
  * **[INFORMATION]** => No prefixes receive for VPNv4 peer

Installation
------------

1. Add a value mapping named `ciscoBgpPeerAdminStatus` with the following value :
  * 1 => stop
  * 2 => start
2. Import **zbx-cisco-bgp4.xml** file into Zabbix.
3. Add to your host the **{$SNMP_COMMUNITY}** macro with your Cisco SNMP community as value.
4. Associate **ZBX-CISCO-BGP4** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.There are no additional requirements.

License
-------

This template is distributed  under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) 2012 Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
