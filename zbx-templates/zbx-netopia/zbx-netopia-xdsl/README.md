ZBX-NETOPIA-xDSL
================

This template use the RFC2662-MIB to discover and manage ADSL controllers.

Items
-----

  * Discovery: ADSL line coding type
  * Discovery: ADSL line downstream attenuation
  * Discovery: ADSL line downstream number of Errored Seconds
  * Discovery: ADSL line downstream number of Loss of Framing
  * Discovery: ADSL line downstream number of Loss of Power failures
  * Discovery: ADSL line downstream number of Loss of Signal failures
  * Discovery: ADSL line downstream SNR
  * Discovery: ADSL line downstream speed
  * Discovery: ADSL line physical entity type
  * Discovery: ADSL line upstream attenuation
  * Discovery: ADSL line upstream number of Errored Seconds
  * Discovery: ADSL line upstream number of Loss of Framing 
  * Discovery: ADSL line upstream number of Loss of Power failures
  * Discovery: ADSL line upstream number of Loss of Signal failures
  * Discovery: ADSL line upstream SNR
  * Discovery: ADSL line upstream speed

Triggers
--------

  * **[INFORMATION]** => Discovery: ADSL line attenuation has changed
  * **[INFORMATION]** => Discovery: ADSL line signal to noise ratio has changed
  * **[INFORMATION]** => Discovery: ADSL line speed has changed

Graphs
------

  * ADSL line attenuation
  * ADSL line SNR margin
  * ADSL line speed

Installation
------------

1. Install [`advsnmp.discovery`](https://github.com/simonkowallik/Zabbix-Addons/tree/master/advsnmp.discovery) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x advsnmp.discovery`
4. Import **zbx-netopia-xdsl.xml** file into Zabbix.
5. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
6. Associate **ZBX-NETOPIA-xDSL** template to the host.
 
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
