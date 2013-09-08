as.name
========

Query whois.cymru.com server to get AS Name associated to the IP address

Installation
------------

1. Install `as.name` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Make sure you have the whois client installed on your Zabbix server and/or proxy.
3. Then chmod a+x `as.name`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

Usage
-----

### As a script
    ./as.name [OPTIONS]

    where OPTIONS are :
    -h, --help                       Display this help message
    -p, --peer BGP_PEER_IP_ADDRESS   BGP peer IP address discovered by Zabbix

### As an item
Use `as.name` like an **External Check** item in Zabbix.  So, when creating an item, select **External Check**.  In the **Key** field, you specify:
    
    as.name["-p","BGP_PEER_IP_ADDRESS"]

Version
-------

Version 1.0

License
-------

This script is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) 2012 Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
