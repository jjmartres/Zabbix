ZBX-FORTINET-VDOM
=================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage virtual domain on Fortinet devices.

Items
-----

  * Discovery: operation mode of each virtual domain

Installation
------------

1. Add a value mapping named `FgOpMode` with the following values:
  * 1 => nat
  * 2 => transparent
3. Import **zbx-fortinet-vdom.xml** file into Zabbix.
4. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-FORTINET-VDOM** template to the host.
 
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
