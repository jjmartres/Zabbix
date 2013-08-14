ZBX-CISCO-INTERFACES
====================

This template use the IF-MIB and CISCO-UDLDP-MIB to discover and manage interfaces of Cisco devices.

Items
-----

  * Discovery: administrative status for each interface
  * Discovery: operational status for earch interface
  * Discovery: speed for each interface
  * Discovery: description for each interface
  * Discovery: alias for each interface
  * Discovery: UDLD configuration for each interface
  * Discovery: UDLD link status for each interface
  * Discovery: incoming traffic on each interface (64Bits counters used)
  * Discovery: outgoing traffic on each interface (64Bits counters used)
  * Discovery: inbound errors on each interface
  * Discovery: outbound errors on each interface
  * Discovery: incoming discarded packets on each interface
  * Discovery: outgoing discarded packets on each interface
  * Discovery: collisions on each interface
  * Discovery: CRC packets on each interface
  * Discovery: giants packets on each interface
  * Discovery: ignored packets on each interface
  * Discovery: misaligned packets on each interface
  * Discovery: overruns packets on each interface
  * Discovery: runts packets on each interface
  * Discovery: the length of the output packet queue for each interface

Triggers
--------

  * **[DISASTER]** => Discovery: operational status was changed for an interface where ifAlias match user macro {$INTF_REGEXP}
  * **[HIGH]** => Discovery: an UDLD link has been detected on an interface
  * **[WARNING]** => Discovery: incoming use on an interface exceed 80% for the last 5 minutes
  * **[WARNING]** => Discovery: outgoing use on an interface exceed 80% for the last 5 minutes
  * **[INFORMATION]** => Discovery: operational status was changed for an interface where ifAlias didn't match user macro {$INTF_REGEXP}
  * **[INFORMATION]** => Discovery: unable to determine UDLD status for an interface
  * **[INFORMATION]** => Discovery: UDLD configuration was changed for an interface
  * **[INFORMATION]** => Discovery: the length of the output packet queue is not empty on each interface

Graphs
------

  * Discovery: traffic (bits/sec, 95th Percentile) for an interface
  * Discovery: errors on an interface
  * Discovery: length of the output packets queue for an interface

Installation
------------

1. Install [`if.speed`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/if.speed) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x if.speed`
3. Add a value mapping named `ciscoCudldpInterfaceOperStatus` with the following values:
  * 1 => shutdwon
  * 2 => indeterminant
  * 3 => biDirectional
  * 4 => notApplicable
4. Add a value mapping named `ciscoCudldpInterfaceOperMode` with the following values:
  * 1 => enable
  * 2 => disable
  * 3 => aggressive
4. Import **zbx-cisco-interfaces.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Add to your host the **{$INTF_REGEXP}** macro with your regular expression as value (ex: -p-|-P-|-pe-|-PE-)
7. Associate **ZBX-CISCO-INTERFACES** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [if.speed](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/if.speed) 1.0

This script quey the speed of an interface using the ifSpeed and ifHighSpeed OID and return the right speed value for an interface.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
