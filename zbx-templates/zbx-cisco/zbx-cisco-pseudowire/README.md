ZBX-CISCO-PSEUDOWIRE
====================

This template use the CISCO-IETF-PW-MIB to discover and manage pseudowire connections on Cisco devices.

Items
-----

  * Discovery: administrative status for each VC
  * Discovery: associated physical interface for each VC
  * Discovery: local description for each VC
  * Discovery: operational status for each VC
  * Discovery: PSN type to carried each VC
  * Discovery: remote description for each VC
  * Discovery: service to be carried on each VC
  * Discovery: uptime for each VC
  * Discovery: label used in the inbound direction for each VC
  * Discovery: label used in the outbound direction for each VC

Triggers
--------

  * **[WARNING]** => Discovery: VC is DOWN
  * **[INFORMATION]** => Discovery: operational status was changed for each VC

Installation
------------

1. Install [`echo.something`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x echo.something`
3. Add a value mapping named `ciscoPwVcAdminStatus` with the following values:
  * 1 => up
  * 2 => down
  * 3 => testing
4. Add a value mapping named `ciscoPwOperStatus` with the following values:
  * 1 => up
  * 2 => down
  * 3 => testing
  * 4 => unknown
  * 5 => dormant
  * 6 => notPresent
  * 7 => lowerlayerDown
5. Add a value mapping named `ciscoPwVcType` with the following values:
  * 0 => other
  * 1 => frameRelay
  * 2 => atmAal5Vcc
  * 3 => atmTransparent
  * 4 => ethernetVLAN
  * 5 => ethernet
  * 6 => hdlc
  * 7 => ppp
  * 8 => cep
  * 9 => atmVccCell
  * 10 => atmVpcCell
  * 11 => ethernetVPLS
  * 12 => e1Satop
  * 13 => t1Satop
  * 14 => e3Satop
  * 15 => t3Satop
  * 16 => basicCesPsn
  * 17 => basicTdmIp
  * 18 => tdmCasCesPsn
  * 19 => tdmCasTdmIp
6. Add a value mapping named `ciscoPwVcPsnType` with the following values:
  * 1 => mpls
  * 2 => l2tp
  * 3 => ip
  * 4 => mplsOverIp
  * 5 => gre
  * 6 => other
7. Import **zbx-cisco-pseudowire.xml** file into Zabbix.
8. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
9. Associate **ZBX-CISCO-PSEUDOWIRE** template to the host.
 
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
