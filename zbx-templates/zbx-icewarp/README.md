ZBX-ICEWARP-SERVER
==================

This template use the IceWarp Server SNMP MIB to manage IceWarp Server.

Items
-----

  * Product name
  * Product version
  * SMTP service status
  * SMTP service uptime
  * POP3 service status
  * POP3 service uptime
  * IMAP service status
  * IMAP service uptime
  * IM service status
  * IM service uptime
  * GroupWare service status
  * GroupWare service uptime 
  * Web/FTP service status
  * Web/FTP service uptime
  * Control service status
  * Control service uptime
  * SMTP transmitted messages
  * SMTP received messages
  * SMTP untransmitted messages
  * SMTP failures (Virus)
  * SMTP failures (Too Data)
  * SMTP failures (Static Filter)
  * SMTP failures (BWFilter)
  * SMTP failures (SPAM)
  * SMTP failures (DNSBL)

Triggers
--------

  * **[HIGH]** => Too many SMTP received messages. Value is greater than macro {$ICEWARP_RECEIVED_MESSAGES}. Default value is 5000.
  * **[HIGH]** => Too many SMTP untransmitted messages. Value is greater than macro {$ICEWARP_UNTRANSMITTED_MESSAGES}. Default value is 200.
  * **[WARNING]** => SMTP service has been restarted
  * **[WARNING]** => POP3 service has been restarted
  * **[WARNING]** => IMAP service has been restarted
  * **[WARNING]** => IM service has been restarted
  * **[WARNING]** => GroupWare service has been restarted
  * **[WARNING]** => Web/FTP service has been restarted
  * **[WARNING]** => Control service has been restarted

Graphs
------

  * SMTP trafic
  * SMTP failures

Installation
------------

1. Configure IceWarp SNMP Server has described [here](http://esupport.icewarp.com/index.php?/Knowledgebase/Article/View/180/16/snmp-in-icewarp)
2. Add a value mapping named `iwpServiceStatus` with the following values:
   * 0 => Not running
   * 1 => Running
3. Import **zbx-icewarp-server.xml** file into Zabbix.
4. Add to your host the followed macro with value **{$ICEWARP_RECEIVED_MESSAGES}**
5. Add to your host the followed macro with value **{$ICEWARP_UNTRANSMITTED_MESSAGES}**
6. Associate **ZBX-ICEWARP-SERVER** template to the host.

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
