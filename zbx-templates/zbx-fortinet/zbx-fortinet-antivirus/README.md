ZBX-FORTINET-ANTIVIRUS
======================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage AntiVirus activity.

Items
-----

  * Discovery: Number of over-sized file transmissions blocked in a particular virtual domain
  * Discovery: Number of over-sized file transmissions detected in a particular virtual domain
  * Discovery: Number of virus transmissions blocked in a particular virtual domain
  * Discovery: Number of virus transmissions detected in a particular virtual domain
  * Discovery: Number of virus transmissions over FTP blocked in a particular virtual domain
  * Discovery: Number of virus transmissions over FTP detected in a particular virtual domain
  * Discovery: Number of virus transmissions over HTTP blocked in the virtual domain
  * Discovery: Number of virus transmissions over HTTP detected in the virtual domain
  * Discovery: Number of virus transmissions over IMAP blocked in the virtual domain
  * Discovery: Number of virus transmissions over IMAP detected in the virtual domain
  * Discovery: Number of virus transmissions over IM protocols blocked in the virtual domain
  * Discovery: Number of virus transmissions over IM protocols detected in the virtual domain
  * Discovery: Number of virus transmissions over NNTP blocked in the virtual domain
  * Discovery: Number of virus transmissions over NNTP detected in the virtual domain
  * Discovery: Number of virus transmissions over POP3 blocked in the virtual domain
  * Discovery: Number of virus transmissions over POP3 detected in the virtual domain
  * Discovery: Number of virus transmissions over SMTP detected in the virtual domain
  * Discovery: Number of virus transmissions over SMTP blocked in the virtual domain

Triggers
--------

  * **[HIGH]** => An increase of 40% of over-sized file transmissions blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of over-sized file transmissions detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over FTP blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over FTP detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over HTTP blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over HTTP detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over IMAP blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over IMAP detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over IM protocols blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over IM protocols detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over NNTP blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over NNTP detected in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over POP3 blocked in a particular virtual domain was detected
  * **[HIGH]** => An increase of 40% of virus transmissions over POP3 detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of over-sized file transmissions blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of over-sized file transmissions detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over FTP blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over FTP detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over HTTP blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over HTTP detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over IMAP blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over IMAP detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over IM protocols blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over IM protocols detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over NNTP blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over NNTP detected in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over POP3 blocked in a particular virtual domain was detected
  * **[AVERAGE]** => An increase of 30% of virus transmissions over POP3 detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of over-sized file transmissions blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of over-sized file transmissions detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over FTP blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over FTP detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over HTTP blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over HTTP detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over IMAP blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over IMAP detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over IM protocols blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over IM protocols detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over NNTP blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over NNTP detected in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over POP3 blocked in a particular virtual domain was detected
  * **[WARNING]** => An increase of 20% of virus transmissions over POP3 detected in a particular virtual domain was detected

Graphs
------

  * Number of over-sized file transmissions in a particular virtual domain
  * Number of virus transmissions in a particular virtual domain
  * Number of virus transmissions over FTP in a particular virtual domain
  * Number of virus transmissions over HTTP in a particular virtual domain
  * Number of virus transmissions over IMAP in a particular virtual domain
  * Number of virus transmissions over IM protocols in a particular virtual domain
  * Number of virus transmissions over NNTP in a particular virtual domain
  * Number of virus transmissions over POP3 in a particular virtual domain

Installation
------------

1. Import **zbx-fortinet-antivirus.xml** file into Zabbix.
2. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
3. Associate **ZBX-FORTINET-ANTIVIRUS** template to the host.

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
