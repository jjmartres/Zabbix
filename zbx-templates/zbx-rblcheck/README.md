ZBX-RBLCHECK
============

This template allow to queries DNS Blacklists for listings.
Actually supported RBLs are :
 * VIRBL               =>     virbl.dnsbl.bit.nl
 * SPAMHAUS            =>     zen.spamhaus.org
 * URIBL               =>     multi.uribl.com
 * SURBL               =>     multi.surbl.org
 * NJABL               =>     dnsbl.njabl.org
 * SPAMCOP             =>     bl.spamcop.net
 * SORBS               =>     dnsbl.sorbs.net
 * AHBL                =>     dnsbl.ahbl.org
 * DRONEBL             =>     dnsbl.dronebl.org
 * BARRACUDA           =>     b.barracudacentral.org
 * DRONE_ABUSE_CH      =>     drone.abuse.ch
 * HTTPBL_ABUSE_CH     =>     httpbl.abuse.ch
 * SPAM_ABUSE_CH       =>     spam.abuse.ch
 * MAILSHELL           =>     dnsbl.mailshell.net
 * CBL                 =>     cbl.abuseat.org
 * RHSBL               =>     rhsbl.ahbl.org
 * FIVETENSG           =>     blackholes.five-ten-sg.com
 * INPS                =>     dnsbl.inps.de
 * MANITU              =>     ix.dnsbl.manitu.net
 * NOMOREFUN           =>     no-more-funn.moensted.dk
 * SPAMCANNIBAL        =>     bl.spamcannibal.org
 * UCEPROTECT1         =>     dnsbl-1.uceprotect.net
 * UCEPROTECT2         =>     dnsbl-2.uceprotect.net
 * UCEPROTECT3         =>     dnsbl-3.uceprotect.net
 * WHITELIST           =>     ips.whitelisted.org
 * BACKSCATTERER       =>     ips.backscatterer.org
 * PROJECTHONEYPOT     =>     dnsbl.httpbl.org
 * TOREXITNODE         =>     torexit.dan.me.uk
 * UNSUBSCORE          =>     ubl.unsubscore.com
 * DYNA_SPAMRATS       =>     dyna.spamrats.com
 * NOPTR_SPAMRATS      =>     noptr.spamrats.com
 * SPAM_SPAMRATS       =>     spam.spamrats.com
 * CBL_ANTISPAM_ORG_CN =>     cbl.anti-spam.org.cn
 * CDL_ANTISPAM_ORG_CN =>     cdl.anti-spam.org.cn
 * SURRIEL             =>     psbl.surriel.com
 * SPAMLAB             =>     rbl.spamlab.com
 * BOGONS_CYMRU        =>     bogons.cymru.com
 * RFC-IGNORANT        =>     dsn.bl.rfc-ignorant.de

Items
-----

  * Queries various DNS blacklists

Triggers
--------

  * **[HIGH]** => Host is blacklisted on VIRBL
  * **[HIGH]** => Host is blacklisted on SPAMHAUS
  * **[HIGH]** => Host is blacklisted on URIBL
  * **[HIGH]** => Host is blacklisted on SURBL
  * **[HIGH]** => Host is blacklisted on NJABL
  * **[HIGH]** => Host is blacklisted on SPAMCOP
  * **[HIGH]** => Host is blacklisted on SORBS
  * **[HIGH]** => Host is blacklisted on AHBL
  * **[HIGH]** => Host is blacklisted on DRONEBL
  * **[HIGH]** => Host is blacklisted on BARRACUDA
  * **[HIGH]** => Host is blacklisted on DRONE_ABUSE_CH
  * **[HIGH]** => Host is blacklisted on HTTPBL_ABUSE_CH
  * **[HIGH]** => Host is blacklisted on SPAM_ABUSE_CH
  * **[HIGH]** => Host is blacklisted on MAILSHELL
  * **[HIGH]** => Host is blacklisted on CBL
  * **[HIGH]** => Host is blacklisted on RHSBL
  * **[HIGH]** => Host is blacklisted on FIVETENSG
  * **[HIGH]** => Host is blacklisted on INPS
  * **[HIGH]** => Host is blacklisted on MANITU
  * **[HIGH]** => Host is blacklisted on NOMOREFUN
  * **[HIGH]** => Host is blacklisted on SPAMCANNIBAL
  * **[HIGH]** => Host is blacklisted on UCEPROTECT1
  * **[HIGH]** => Host is blacklisted on UCEPROTECT2
  * **[HIGH]** => Host is blacklisted on UCEPROTECT3
  * **[HIGH]** => Host is blacklisted on WHITELIST
  * **[HIGH]** => Host is blacklisted on BACKSCATTERER
  * **[HIGH]** => Host is blacklisted on PROJECTHONEYPOT
  * **[HIGH]** => Host is blacklisted on TOREXITNODE
  * **[HIGH]** => Host is blacklisted on UNSUBSCORE
  * **[HIGH]** => Host is blacklisted on DYNA_SPAMRATS
  * **[HIGH]** => Host is blacklisted on NOPTR_SPAMRATS
  * **[HIGH]** => Host is blacklisted on SPAM_SPAMRATS
  * **[HIGH]** => Host is blacklisted on CBL_ANTISPAM_ORG_CN
  * **[HIGH]** => Host is blacklisted on CDL_ANTISPAM_ORG_CN
  * **[HIGH]** => Host is blacklisted on SURRIEL
  * **[HIGH]** => Host is blacklisted on SPAMLAB
  * **[HIGH]** => Host is blacklisted on BOGONS_CYMRU
  * **[HIGH]** => Host is blacklisted on RFC-IGNORANT

Installation
------------

1. Install [`rbl.check`](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/zbx-rblcheck) in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x rbl.check`
3. Import **zbx-rblcheck.xml** file into Zabbix.
4. Associate **ZBX-RBLCHECK** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [rbl.check](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/rbl.check) 1.1

This script queries DNS Blacklists for listings.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
