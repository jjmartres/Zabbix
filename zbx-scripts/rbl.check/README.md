rbl.check
=========

This script queries DNS Blacklists for listings.

Installation
------------

1. Install `rbl.check` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then chmod a+x `rbl.check`
3. Install DNSBL-Client gem `gem install dnsbl-client`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

###### [DNSBL::Client](https://github.com/chrislee35/dnsbl-client) 1.0.0

This script require DNSBL::Client gem 1.0.0 or higher.

Usage
-----

### As a script
    ./rbl.check [OPTIONS]

    where OPTIONS are :
     -h, --help                       Display this help message
     -q, --query Flag                 Flag: RBLS or IP_ADDRESS

### As an item
Use `rbl.check` like an **External Check** item in Zabbix.  So, when creating an item, select **External Check**.  In the **Key** field, you specify:

    rbl.check["-q","RBLS|IP_ADDRESS"]

### Supported RBLS
  VIRBL               =>     virbl.dnsbl.bit.nl
  SPAMHAUS            =>     zen.spamhaus.org
  URIBL               =>     multi.uribl.com
  SURBL               =>     multi.surbl.org
  NJABL               =>     dnsbl.njabl.org
  SPAMCOP             =>     bl.spamcop.net
  SORBS               =>     dnsbl.sorbs.net
  AHBL                =>     dnsbl.ahbl.org
  DRONEBL             =>     dnsbl.dronebl.org
  BARRACUDA           =>     b.barracudacentral.org
  DRONE_ABUSE_CH      =>     drone.abuse.ch
  HTTPBL_ABUSE_CH     =>     httpbl.abuse.ch
  SPAM_ABUSE_CH       =>     spam.abuse.ch
  MAILSHELL           =>     dnsbl.mailshell.net
  CBL                 =>     cbl.abuseat.org
  RHSBL               =>     rhsbl.ahbl.org
  FIVETENSG           =>     blackholes.five-ten-sg.com
  INPS                =>     dnsbl.inps.de
  MANITU              =>     ix.dnsbl.manitu.net
  NOMOREFUN           =>     no-more-funn.moensted.dk
  SPAMCANNIBAL        =>     bl.spamcannibal.org
  UCEPROTECT1         =>     dnsbl-1.uceprotect.net
  UCEPROTECT2         =>     dnsbl-2.uceprotect.net
  UCEPROTECT3         =>     dnsbl-3.uceprotect.net
  WHITELIST           =>     ips.whitelisted.org
  BACKSCATTERER       =>     ips.backscatterer.org
  PROJECTHONEYPOT     =>     dnsbl.httpbl.org
  TOREXITNODE         =>     torexit.dan.me.uk
  UNSUBSCORE          =>     ubl.unsubscore.com
  DYNA_SPAMRATS       =>     dyna.spamrats.com
  NOPTR_SPAMRATS      =>     noptr.spamrats.com
  SPAM_SPAMRATS       =>     spam.spamrats.com
  CBL_ANTISPAM_ORG_CN =>     cbl.anti-spam.org.cn
  CDL_ANTISPAM_ORG_CN =>     cdl.anti-spam.org.cn
  SURRIEL             =>     psbl.surriel.com
  SPAMLAB             =>     rbl.spamlab.com
  BOGONS_CYMRU        =>     bogons.cymru.com
  RFC-IGNORANT        =>     dsn.bl.rfc-ignorant.de

Version
-------

Version 1.1

License
-------

This script is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
