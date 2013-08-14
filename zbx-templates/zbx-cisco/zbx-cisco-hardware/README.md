ZBX-CISCO-HARDWARE
==================

This template use the ENTITY-MIB to discover and manage physical entity of Cisco devices.

Items
-----

  * Discovery: firmware revision for each physical entity
  * Discovery: hardware revision for each physical entity
  * Discovery: serial number for each physical entity
  * Discovery: software version for each physical entity

Triggers
--------

  * **[INFORMATION]** => Discovery: serial number was changed for each physical entity

Installation
------------

1. Import **zbx-cisco-hardware.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-CISCO-HARDWARE** template to the host.
 
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
