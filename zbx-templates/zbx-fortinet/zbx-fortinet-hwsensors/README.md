ZBX-FORTINET-HWSENSORS
===================

This template use the FORTINET-CORE-MIB and FORTINET-FORTIGATE-MIB to discover and manage Hardware Sensors.

Items
-----

  * Discovery: Fan speed on each sensors
  * Discovery: Fan alarm status on each sensors
  * Discovery: Temperature on each sensors
  * Discovery: Temperature alarm status on each sensors
  * Discovery: Voltage on each sensors
  * Discovery: Voltage alarm status on each sensors
  * Discovery: PowerSupply alarm status on each Power Supply Units.

Triggers
--------

  * **[HIGH]** => a particular FAN was on alarm status
  * **[HIGH]** => a particular Temperature sensor was on alarm status
  * **[HIGH]** => a particular Voltage sensor was on alarm status
  * **[WARNING]** => a particular Power Supply Unit CPU was on alarm status

Graphs
------

  * Fan speed on each sensors
  * Temperature on each sensors
  * Voltage on each sensors

Installation
------------

1. Add a value mapping named `fgHwSensorEntAlarmStatus` with the following values:
  * 0 => false
  * 1 => true
2. Import **zbx-fortinet-hwsensors.xml** file into Zabbix.
3. Add to your host the **{$SNMP_COMMUNITY}** macro with your SNMP community as value.
4. Associate **ZBX-FORTINET-HWSENSORS** template to the host.
 
### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### FortiGate Supported

These hardware sensors are supported on a few FortiGate models(600C/1000C/3040B/3140B/3950B,etc).
If you want to use this templates on newer models with different sensor name, 
you have to modify the filter regular expression in discovery rule with macro **{#SNMPVALUE}**.

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors
  
  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
