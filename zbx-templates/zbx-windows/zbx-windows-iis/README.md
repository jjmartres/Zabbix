ZBX-WINDOWS-IIS
===============

This template use Zabbix agent to discover and manage IIS server.

Items
-----

  * ASP.Net Total errors
  * ASP.Net Worker process restarts
  * ASP.Net Number of current requests
  * ASP.Net Application restarts
  * ASP.Net Requests/sec
  * IIS Current anonymous users
  * IIS Current connections
  * IIS Post requests/s
  * IIS Head requests/s
  * IIS Get requests/s
  * IIS Current nonanonymous users

Triggers
--------

  * **[AVERAGE]** =>  IIS application pool restart on {HOST.NAME}

Graphs
------

  * IIS Counters overview

Installation
------------

1. Install the Zabbix agent on your host or download my automated package [`Zabbix agent`](https://github.com/jjmartres/Zabbix/tree/master/zbx-agent)

  If your choose to install the Zabbix agent from the source, you need to :
  1. Add the following line to your Zabbix agent configuration file. Note that `<zabbix_script_path>` is your Zabbix agent script path :

    EnableRemoteCommands=1
    UnsafeUserParameters=1

  2. Import **zbx-windows-iis.xml** file into Zabbix.
  3. Associate **ZBX-WINDOWS-IIS** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

##### [Zabbix agent](http://www.zabbix.com) 2.0.x

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

Copyright (c) Jean-Jacques Martrès

### Authors

Jean-Jacques Martrès
(jjmartres |at| gmail |dot| com)
