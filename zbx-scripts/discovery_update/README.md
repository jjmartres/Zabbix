discovery_update
================

This extend the capabilites of Zabbix dicovery process for SNMP device.

Installation
------------

1. Install `discovery_update` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then `chmod a+x discovery_update`
3. Install SNMP gem `gem install snmp`
4. Install SNMP gem `gem install rubix`
5. Configure your Discovery rules
6. Create Actions rules that match your Discovery rules and add your discovered hosts to a specified group, remove from the Discovered hosts and disable the host.
7. Create a configuration file like this :
    api:
      url:                "zabbix api url"
      login:              "zabbix username"
      password:           "zabbix password"

    your-proxy-name:
      group:              "host group name"
      snmp_community:     "device SNMP community"
      rules:              "[['TEMPLATE_NAME_1','regex1'],['TEMPLATE_NAME_2','regex2']]"

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

###### [Net-Ping](http://rubygems.org/gems/net-ping) 1.5.3

This script require net-ping gem 1.5.3 or higher


Usage
-----

### As a script
    ./discovery_update [OPTIONS]

    OPTIONS
      -h, --help                       Display this help message
      -c, --config CONFIG_FILE         Configuration file

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
