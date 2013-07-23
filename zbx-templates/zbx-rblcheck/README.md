ZBX-RBLCHECK
============

This template allow to queries DNS Blacklists for listings.

Items
-----

  * Queries various DNS blacklists

Triggers
--------

  * **[HIGH]** => Host is listed on some RBLs

Installation
------------

1. Install [`rbl.check`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/zbx-rblcheck) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x rbl.check`
3. Import **zbx-rblcheck.xml** file into Zabbix.
4. Associate **ZBX-RBLCHECK** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [rbl.check](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/rbl.check) 1.0

This script queries DNS Blacklists for listings.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) 2013 Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
