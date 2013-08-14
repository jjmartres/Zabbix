ZBX-FORTINET-IDS
================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage virtual domain on Fortinet devices.

Items
-----

  * Discovery: number of intrusions blocked for each virtual domain
  * Discovery: number of intrusions detected for each virtual domain

Triggers
--------

  * **[HIGH]** => An increase of 40% of detected intrusions for each virtual domain was detected
  * **[HIGH]** => An increase of 40% of blocked intrusions for each virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of detected intrusions for each virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of blocked intrusions for each virtual domain was detected
  * **[INFORMATION]** => An increase of 20% of detected intrusions for each virtual domain was detected
  * **[INFORMATION]** => An increase of 20% of blocked intrusions for each virtual domain was detected

Installation
------------

1. Add a value mapping named `FgOpMode` with the following values:
  * 1 => nat
  * 2 => transparent
3. Import **zbx-fortinet-ids.xml** file into Zabbix.
4. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-FORTINET-IDS** template to the host.
 
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
