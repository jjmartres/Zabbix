ZBX-FORTINET-VPN
================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage VPN on Fortinet devices.

Items
-----

  * Discovery: associated virtual domain for each VPN
  * Discovery: current status for each VPN
  * Discovery: local IP address for each VPN
  * Discovery: remote IP address for each VPN
  * Discovery: number of bytes received on each VPN
  * Discovery: number of bytes sent on each VPN

Triggers
--------

  * **[INFORMATION]** => VPN tunnel is DOWN

Graphs
------

  * Discovery: traffic for each VPN

Installation
------------

1. Add a value mapping named `FgVpnState` with the following values:
  * 1 => down
  * 2 => up
2. Install [`vpn.vdom`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/vpn.vdom) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
3. Then `chmod a+x vpn.vdom`
4. Import **zbx-fortinet-vpn.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-FORTINET-VPN** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [vpn.vdom](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/vpn.vdom) 1.0

This script show asssociated VDOM for a VPN tunnel using SNMP on FortiNet device.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
