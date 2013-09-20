ZBX-BROCADE-FC-PORT
===================

This template use the SW-MIB and IF-MIB to discover and manage FC ports.

Items
-----

  * Discovery: administrative status for each port
  * Discovery: operational status for earch port
  * Discovery: speed for each port
  * Discovery: description for each port
  * Discovery: WWN for each port
  * Discovery: transmitter type for each port
  * Discovery: incoming traffic on each port
  * Discovery: outgoing traffic on each port
  * Discovery: words received on each port
  * Discovery: words transmitted on each port 
  * Discovery: frames received on each port
  * Discovery: frames transmitted on each port
  * Discovery: class2 frames received on each port
  * Discovery: class3 frames received on each port
  * Discovery: multicast frames received on each port
  * Discovery: multicast frames transmitted on each port
  * Discovery: CRC errors received on each port
  * Discovery: disparity errors received on each port
  * Discovery: encoding and disparity errors in frames received on each port
  * Discovery: truncated frames received on each port
  * Discovery: truncated too-long frames received on each port
  * Discovery: bad EOF delimited frames received on each port

Triggers
--------

  * **[HIGH]** => Discovery: error(s) was detected on each port
  * **[AVERAGE]** => Discovery: operational status was changed on each port

Graphs
------

  * Discovery: monitor (FC counters) on each port
  * Discovery: traffic on each port

Installation
------------

1. Add a value mapping named `swFcPortStatus` with the following values:
  * 0 => unknown
  * 1 => online
  * 2 => offline
  * 3 => testing
  * 4 => faulty
2. Add a value mapping named `swFcPortSpeed` with the following values:
  * 1 => 1 Gb
  * 2 => 2 Gb
  * 3 => Auto-Negotiate
  * 4 => 4 Gb
  * 5 => 8 Gb
  * 6 => 10 Gb
  * 7 => unknown
3. Add a value mapping named `swFcPortTXType`with the following values:
  * 1 => unknown
  * 2 => long wave laser
  * 3 => short wave laser
  * 4 => long wave LED
  * 5 => copper (electrical)
4. Install [`advsnmp.discovery`](https://github.com/simonkowallik/Zabbix-Addons/tree/master/advsnmp.discovery) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
5. Then `chmod a+x advsnmp.discovery`
6. Import **zbx-brocade-fc-port.xml** file into Zabbix.
7. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
8. Associate **ZBX-BROCADE-FC-PORT** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [advsnmp.discovery](https://github.com/simonkowallik/Zabbix-Addons/tree/master/advsnmp.discovery) 2.0

This template use this script as an alternative to the build-in SNMP low level discovery of Zabbix.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
