ZBX-CISCO-OPTICAL-MONITORING
============================

This template use the CISCO-ENTITY-SENSOR-MIB to discover and manage DOM optical sensors.

Items
-----

  * Discovery: interface name with DOM optical transceiver sensor
  * Discovery: high alarm threshold for each sensor
  * Discovery: high warn threshold for each sensor
  * Discovery: low alarm threshold for each sensor
  * Discovery: low warn threshold for each sensor

Triggers
--------

  * **[HIGH]** => Discovery: high signal alarm for each sensor
  * **[HIGH]** => Discovery: low signal alarm for each sensor
  * **[WARNING]** => Discovery: high signal warning for each sensor
  * **[WARNING]** => Discovery: low signal warning for each sensor

Installation
------------

1. Import **zbx-cisco-optical-monitoring.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-CISCO-OPTICAL-MONITORING** template to the host.
 
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
