ZABBIX AGENT INSTALLER
======================

This package is made for installing Zabbix agent (compiled by ZABBIX SIA) on windows environement.

Installation
------------

	zabbix_agent-<version>_installer.exe [/server=ZabbixServerIPAddress] [/lport=ListenPort] [/serveractive=List IP:Port] [/rmtcmd=1] [/S][/D=InstallPath]

where:
* /server=ZabbixServerIPAddress : IP address of the ZABBIX server
* /lport=listenPort : Agent will listen on this port for connections from the server
* /rmtcmd=1 : 1 to enable remote commands, 0 to disable remote command
* /serveractive=List IP:Port : list of Zabbix server for active checks Comma delimited
* /S : Silent mode. If not indicated on the command line, the install GUI will prompt for confirmation of the indicated parameters (server and rmtcmd).
* /D=InstallPath :sets the default installation directory. It must be the last parameter used in the command line and must not contain any quotes, even if the path contains spaces.

Requirements
------------

No requirements.

Credits
-------

* **Vincent Besançon** - NSIS wizard. Thank's to nullsoft NSIS magic
* **ZABBIX SIA** of course 

License
-------

This scripts are distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) 2013 Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
