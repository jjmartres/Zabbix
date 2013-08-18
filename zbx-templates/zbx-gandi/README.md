ZBX-GANDI
============

This template manage domain and certificate expiry from [Gandi](https://www.gandi.net) API.

Items
-----

  * Number of domains (all status) associated to the API key
  * Number of certificates (all status) associated to the API key
  * Discovery : validity for each domain (in days)
  * Discovery : validity for each certificate (in days)

Triggers
--------

  * **[DISASTER]** => Discovery: Domain expired
  * **[DISCASTER]** => Discovery: SSL certificate expired 
  * **[HIGH]** => Discovery: domain expires in less than 7 days 
  * **[HIGH]** => Discovery: SSL certificate expires in less than 7 days
  *  **[AVERAGE]** => Discovery: domain expires in less than 15 days
  *  **[AVERAGE]** => Discovery: SSL certificate expires in less than 15 days
  *  **[WARNING]** => Discovery: domain expires in less than 30 days
  *  **[WARNING]** => Discovery: SSL certificate expires in less than 30 days
  *  **[INFORMATION]** => Discovery: domain expires in less than 60 days
  *  **[INFORMATION]** => Discovery: SSL certificates expires in less than 60 days

Installation
------------

1. Install [`gandi.check`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/gandi-rblcheck) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x gandi.check`
3. Create a host named GANDI with the IP address 127.0.0.1
4. Add to your host the followed macro with value **{$GANDI_API_KEY}** 
3. Import **zbx-gandi.xml** file into Zabbix.
4. Associate **ZBX-GANDI** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [Gandi](https://www.gandi.net) account with API key

###### [gandi.check](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/gandi.check) 2.0.5

This script query the Gandi API to get information on domain and certificate.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
