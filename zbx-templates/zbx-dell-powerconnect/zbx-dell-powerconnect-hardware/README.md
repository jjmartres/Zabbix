ZBX-DELL-POWERCONNECT-HARDWARE
==============================

This template use the DELL-ITA-MIB to discover and manage physical entity of Dell devices.

Items
-----

  * Discovery: asset tag for each unit
  * Discovery: bootrom version for each unit
  * Discovery: chassis service tag for each unit
  * Discovery: serial number for each unit
  * Discovery: service tag for each unit

Triggers
--------

  * **[INFORMATION]** => Discovery: bootrom version was changed for each unit
  * **[INFORMATION]** => Discovery: serial number was changed for each unit

Installation
------------

1. Import **zbx-dell-powerconnect-hardware.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-DELL-POWERCONNECT-HARDWARE** template to the host.
 
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
