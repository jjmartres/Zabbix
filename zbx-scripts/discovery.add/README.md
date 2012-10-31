discovery.add
=============

This script extend discovery rules, by adding discoverd devices to specified group, with specified template.

Installation
------------

1. Install `discovery.add` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x discovery.add`
3. Install SNMP gem `gem install snmp`
4. Install SNMP gem `gem install rubix`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

###### [SNMP](http://rubygems.org/gems/snmp) 1.1.0

This script require SNMP gem 1.1.0 or higher.

###### [RUBIX](http://rubygems.org/gems/rubix) 0.5.14

This script require RUBIX gem 0.5.14 or higher

Usage
-----

### As a script
    ./discovery.add [OPTIONS]

    OPTIONS
      -h, --help                       Display this help message
      -u, --url API_URL                Zabbix API URL
      -l, --login API_USERNAME         Zabbix username to access the API
      -p, --password API_PASSWORD      Zabbix password to access the API
      -d, --device IP_ADDRESS          Device IP address discovered by Zabbix
      -c, --community SNMP_COMMUNITY   SNMP community used for the device
      -x, --proxy PROXY_NAME           Zabbix proxy host that will manage the device
      -g, --group GROUP_NAME           Zabbix host group to add the device
      -r, --rules RULES                Rules to associate templates to discovered devices. Ex: "[['template1','regexp1'],['template2','regexp2']]"

    EXAMPLE

      `discovery.add -u http://zabbix/api_jsonrpc.php -l USER_NAME -p USER_PASSWORD -d DISCOVERY.DEVICE.IPADDRESS -c ZABBIX_COMMUNITY -x ZABBIX_PROXY -g MY_GROUP -r "[['MY-CISCO-TEMPLATE','isco'],['MY-NETOPIA-TEMPLATE','etopia']]"`

Version
-------

Version 1.0

License
-------

This scriptis distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) 2012 Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
