ZBX-CISCO-VPDN
==============

This template use the CISCO-VPDN-MGMT-MIB to discover and manage Virtual Private Dialup Network.

Items
-----

  * VPDN sessions inside L2TP tunnels
  * L2TP tunnels
  * SDSL links

Triggers
--------

  * **[WARNING]** => lost of all l2TP tunnels
  * **[WARNING]** => lost of all VPDN tunnels

Graphs
------

  * VPDN sessions
  * L2TP tunnels
  * SDSL links

Installation
------------

1. Import **zbx-cisco-vpdn.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-CISCO-VPDN** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.There are no additional requirements.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
