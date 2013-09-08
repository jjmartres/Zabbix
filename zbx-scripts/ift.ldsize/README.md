ift.ldsize
==========

This script query ldSize OID from the Infortrend MIB (IFT-SNMP-MIB) to get the logical drive size.

Installation
------------

1. Install `ift.ldsize` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then chmod a+x `ift.ldsize`
3. Install SNMP gem `gem install snmp`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

###### [SNMP](http://rubygems.org/gems/snmp) 1.1.0

This script require SNMP gem 1.1.0 or higher.

Usage
-----

### As a script
    ./ift.ldsize [OPTIONS]

    where OPTIONS are :
     -h, --help                       Display this help message
     -d, --device IP_ADDRESS          Device IP address discovered by Zabbix
     -c, --community SNMP_COMMUNITY   SNMP community used for the device
     -i, --id LD_INDEX                Logical drive index
     -b, --block BLOCK_SIZE           Block size value

### As an item
Use `ift.ldsize` like an **External Check** item in Zabbix.  So, when creating an item, select **External Check**.  In the **Key** field, you specify:
    
    ift.ldsize["-d","IP_ADDRESS","-c","SNMP_COMMUNITY","-i","LD_INDEX","-b","BLOCK_SIZE"]

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
