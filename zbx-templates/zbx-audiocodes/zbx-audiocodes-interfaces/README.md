ZBX-AUDIOCODES-INTERFACES
=========================

This template use the IF-MIB to discover and manage interfaces of Audiocodes devices.

Items
-----

  * Discovery: administrative status for each interface
  * Discovery: operational status for earch interface
  * Discovery: speed for each interface
  * Discovery: description for each interface
  * Discovery: alias for each interface
  * Discovery: incoming traffic on each interface
  * Discovery: outgoing traffic on each interface
  * Discovery: inbound errors on each interface
  * Discovery: outbound errors on each interface
  * Discovery: incoming discarded packets on each interface
  * Discovery: outgoing discarded packets on each interface

Triggers
--------

  * **[WARNING]** => Discovery: incoming use on an interface exceed 80% for the last 5 minutes
  * **[WARNING]** => Discovery: outgoing use on an interface exceed 80% for the last 5 minutes
  * **[INFORMATION]** => Discovery: operational status was changed for an interface

Graphs
------

  * Discovery: traffic (bits/sec, 95th Percentile) for an interface
  * Discovery: errors on an interface

Installation
------------

1. Install [`if.speed`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/if.speed) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x if.speed`
3. Add a value mapping named `acSysTypeProduct` with the following values:
 * 0 => Unknown
 * 1 => TrunkPac-08
 * 2 => MediaPack-108
 * 3 => MediaPack-124
 * 20 => TrunkPack-1600
 * 22 => TPM1100
 * 23 => TrunkPack-260-IPMEdia
 * 24 => TrunkPack-1610
 * 25 => MediaPack-104
 * 26 => MediaPack-102
 * 29 => TrunkPack-1610-SB
 * 30 => TrunkPack-1610-IPMedia
 * 31 => TrunkPack-MEDIANT2000
 * 32 => TrunkPack-STRETTO2000
 * 33 => TrunkPack-IPMServer2000
 * 34 => TrunkPack-2810
 * 35 => TrunkPack-260-UN-IPMedia
 * 36 => TrunkPack-260-IPMedia-30Ch
 * 37 => TrunkPack-260-IPMedia-60Ch
 * 38 => TrunkPack-260-IPMedia-120Ch
 * 39 => TrunkPack-260RT-IPMedia-30Ch
 * 40 => TrunkPack-260RT-IPMedia-60Ch
 * 41 => TrunkPack-260RT-IPMedia-120Ch
 * 42 => TrunkPack-260
 * 43 => TrunkPack-260-UN
 * 44 => TPM1100-PCM
 * 45 => TrunkPack-6310
 * 46 => TPM6300
 * 47 => Mediant1000
 * 48 => IPMedia3000
 * 49 => Mediant3000
 * 50 => Stretto3000
 * 51 => TrunkPack-6310-IPMedia
 * 52 => TrunkPack-6310-SB
 * 53 => ATP-1610
 * 54 => ATP-260
 * 55 => ATP-260-UN
 * 56 => MediaPack-118
 * 57 => MediaPack-114
 * 58 => MediaPack-112
 * 59 => TrunkPack-6310-T3
 * 60 => Mediant3000-T3
 * 61 => IPMedia3000-T3
 * 62 => TrunkPack-6310-T3-IPMedia
 * 63 => TrunkPack-8410
 * 64 => TrunkPack-8410-IPMedia
 * 65 => Mediant600
 * 66 => TrunkPack-12610
 * 67 => Mediant1000-MSBG
 * 68 => Mediant600-MSBG
 * 69 => Mediant800-MSBG
 * 71 => Mediant1000-ESBC
 * 72 => Mediant800-ESBC
4. Import **zbx-audiocodes-interfaces.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-AUDIOCODES-INTERFACES** template to the host.

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
