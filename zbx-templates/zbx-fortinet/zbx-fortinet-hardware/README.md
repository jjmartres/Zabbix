ZBX-FORTINET-HARDWARE
=====================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage hardware.

Items
-----

  * Discovery: serial number of each cluster unit
  * Discovery: software version of each cluster unit

Triggers
--------

  * **[INFORMATION]** => serial number for each cluster unit was changed

Installation
------------

1. Import **zbx-fortinet-hardware.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-FORTINET-HARDWARE** template to the host.

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
