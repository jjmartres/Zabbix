ZABBIX SCRIPTS
==============

A collection scripts to be used with Zabbix.

Scripts
-------

  * [echo.something](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/echo.something) => simply echo a string.
  * [if.speed](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/if.speed) => script to query the speed of an interface using the ifSpeed and ifHighSpeed OID and return the right speed value for an interface.
  * [if.count](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/if.count) => script query ifType and count interface matching a regexp.
  * [discovery.add](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/discovery.add) => script extend discovery rules, by adding discoverd devices to specified group, with specified template.
  * [powerconnect.optical](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/powerconnect.optical) => script query optical transceiver on Dell PowerConnect switches.
  * [if.vdom](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/if.vdom) => script to get associated VDOM for an interface on Fortinet devices.
  * [vpn.vdom](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/vpn.vdom) => script show asssociated VDOM for a VPN tunnel using SNMP on Fortinet device.
  * [as.name](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/as.name) => script to query **whois.cymru.com** server to get AS Name associated to the IP address.
  * [ift.ldmode](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/lft.ldmode) => script query ldOpModes OID from the Infortrend MIB (IFT-SNMP-MIB) to get the logical drive operating mode.
  * [ift.ldstatus](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/lft.ldstatus) => script query ldStatus OID from the Infortrend MIB (IFT-SNMP-MIB) to get the logical drive status.
  * [ift.ldsize](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/lft.ldsize) => script query ldSize OID from the Infortrend MIB (IFT-SNMP-MIB) to get the logical drive size.
  * [rbl.check](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/rbl.check) => script queries DNS Blacklists for listings.
  * [gandi.check](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/gandi.check) => script  query Gandi API to manage domain and certificate.
* [vsphere.check](https://github.com/jjmartres/Zabbix/tree/master/zbx-scripts/vsphere.check) => script  query vSphere API to manage VMWARE Infrastructure.

Requirements
------------

All this scripts were tested for Zabbix 2.0.0 and higher. Please see individual README for requirements.

License
-------

This scripts are distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
