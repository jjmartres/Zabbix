ZBX-CISCO-HSRP
==============

This template use the CISCO-HSRP-MIB to discover and manage HSRP groups on Cisco devices.

Items
-----

  * Discovery: active IP address of each HSRP group
  * Discovery: standby IP address of each HSRP group
  * Discovery: state of each HSRP group
  * Discovery: virtual IP address of each HSRP group

Triggers
--------

  * **[WARNING]** => Discovery: unexpected state change for each HSRP group

Installation
------------

1. Install [advsnmp.discovery](https://github.com/simonkowallik/Zabbix-Addons/tree/master/advsnmp.discovery) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x advsnmp.discovery`
3. Add a value mapping named `ciscoHsrpGrpStandbyState` with the following values:
  * 1 => initial
  * 2 => learn
  * 3 => listen
  * 4 => speak
  * 5 => standby
  * 6 => active
4. Import **zbx-cisco-hsrp.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-CISCO-HSRP** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 or higher.

###### [advsnmp.discovery](https://github.com/simonkowallik/Zabbix-Addons/tree/master/advsnmp.discovery) 2.0

This template use this script as an alternative to the build-in SNMP low level discovery of Zabbix.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
