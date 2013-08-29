ZBX-DRBD
========

This template allow to manage [DRBD](http://www.drbd.org) ressources.

Items
-----

  * DRBD disk status
  * DRBD disk role
  * DRBD connection state

Triggers
--------

  * **[HIGH]** => DRBD disk is not up to date
  * **[HIGH]** => DRBD connection failed
  * **[WARNING]** => DRBD disk role was changed

Installation
------------

1. Add `userparameter_drbd.conf` file into your `zabbix_agentd.conf.d ` directory.
2. Make sure that your `zabbix_agentd.conf` include `zabbix_agentd.conf.d` directory.
3. Import **zbx-drbd.xml** file into Zabbix.
4. Associate **ZBX-DRBD** template to the host.
5. Start or restart Zabbix Agent

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
