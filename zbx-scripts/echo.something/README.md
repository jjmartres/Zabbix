echo.something
==============

This script echo a string.

Installation
------------

1. Install `echo.something` in the **ExternalScripts** directory of your Zabbix server and/or proxy. Check your `zabbix_server.conf` and/or `zabbix_proxy.conf` if in doubt.
2. Then chmod a+x `echo.something`

### Requirements

This script was tested for Zabbix 2.0.0 or higher.

###### [Ruby](http://www.ruby-lang.org/en/downloads/) 1.8.7

This script require Ruby 1.8.7 or higher.

Usage
-----

### As a script
    ./echo.something "some string"

### As an item
Use `echo.something` like an "**External Check**" item in Zabbix.  So, when creating an item, select "**External Check**".  In the "**Key**" field, you specify:
    
    echo.something["ARGUMENT"]

Version
-------

Version 1.0

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) 2012 Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
