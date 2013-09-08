gandi.check
===========

This script query [Gandi](https://www.gandi.net) API to manage domain and certificate.

Installation
------------

1. Install `gandi.check` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then chmod a+x `rbl.check`
3. Install gem dependencies `gem install hashie`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

###### [Hashie](https://github.com/intridea/hashie) 2.0.5

This script require Hashie gem 2.0.5 or higher.

Usage
-----

### As a script
    ./gandi.check [OPTIONS]

    where OPTIONS are :
     -h, --help                       Display this help message
     -q, --query QUEYRY_FLAG          DOMAIN_LIST, DOMAIN_COUNT, DOMAIN_EXPIRY, CERT_LIST, CERT_COUNT, CERT_EXPIRY
     -k, --apikey API_KEY             24-character API key
     -i, --item ITEM                  Domain name or certificate id

### As an item
Use `gandi.check` like an **External Check** item in Zabbix.  So, when creating an item, select **External Check**.  In the **Key** field, you specify:

    gandi.check["-q","QUEYRY_FLAG","-k","API_KEY","-i","ITEM"]

Version
-------

Version 2.0.5

License
-------

This script is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
