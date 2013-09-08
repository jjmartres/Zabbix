powerconnect.optical
====================

This script query optical transceiver on Dell PowerConnect switches.

Installation
------------

1. Install `powerconnect.optical` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then chmod a+x `powerconnect.optical`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

###### [RubyGems](http://rubygems.org) 1.8

This script require RubyGems 1.8 or higher.

Usage
-----

### As a script
    ./powerconnect.optical [OPTIONS]

    OPTIONS
      -h, --help                       Display this help message
      -a, --address IP_ADDRESS         IP address to query
      -u, --user USERNAME              Username used to telnet the host
      -p, --password PASSWORD          Username associated password
      -i, --interface INTERFACE        Transceiver interface to query
      -q, --query FLAG                 Flag: TEMP|VOLTAGE|CURRENT|OUTPUTPOWER|INPUTPOWER|TXFAULT|LOS
            TEMP - Internally measured transceiver temperatures.
            VOLTAGE - Internally measured supply voltage.
            CURRENT - Measured TX bias current.
            OUTPUTPOWER - Measured optical output power relative to 1mW.
            INPUTPOWER - Measured optical power received relative to 1mW.
            TXFAULT - Transmitter fault:      if Yes return 1, if No return 2
            LOS - Loss of signal:             if Yes return 1, if No return 2
       -d, --debug                      Set debug flag

### As an item
Use `powerconect.optical` like an **External Check** item in Zabbix.  So, when creating an item, select **External Check**.  In the **Key** field, you specify:

    powerconnect.optical["-a","IP_ADDRESS","-u","USERNAME","-p","PASSWORD","-i","INTERFACE","-q","FLAG"]

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
