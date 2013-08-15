ZBX-SMSTOOLS
============

This template allow to manage SMSTOOLS.

Items
-----

  * Number of checked SMS
  * Number of failed SMS
  * Number of incoming SMS
  * Number of outgoing SMS
  * Number of sent SMS

Triggers
--------

  * **[WARNING]** => Failed to send some SMS

Installation
------------

1. Add the following line to your Zabbix agent configuration file. 

    ```
    EnableRemoteCommands=1
    UnsafeUserParameters=1
    UserParameter=smstools[*],ls /var/spool/sms/$1 | wc -l
    ```
2. Import **zbx-smstools.xml** file into Zabbix.
3. Associate **ZBX-SMSTOOLS** template to the host.

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
