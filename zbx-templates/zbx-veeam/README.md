ZBX-VEEAM-BACKUP
================

This template use the VEEAM Backup & Replication PowerShell Cmdlets to discover and manage VEEAM Backup job.

Items
-----

  * Number of running jobs
  * Discovery : status for each jobs
  * Discovery : type for each jobs
  * Discovery : number of virtual machine in each jobs
  * Discovery : size included in each jobs
  * Discovery : size excluded in each jobs

Triggers
--------

  * **[HIGH]** => Discovery: Job has FAILED
  * **[AVERAGE]** => Too many running jobs. Value is greater than macro {$VEEAM\_MAX\_RUNNING\_JOB}
  * **[WARNING]** => Discovery: Job has completed with WARNING

Graphs
------

  * Running VEEAM jobs
  * Discovery : size of each jobs

Installation
------------

1. Install the Zabbix agent on your host or download my automated package [`Zabbix agent`](https://github.com/jjmartres/Zabbix/tree/master/zbx-agent)

  If your choose to install the Zabbix agent from the source, you need to :
  1. Install [`zabbix_vbr_job.ps1`](https://github.com/jjmartres/Zabbix/tree/master/zbx-templates/zbx-veeam/zabbix_vbr_job.ps1) in the script directory of your Zabbix agent.
  2. Add the following line to your Zabbix agent configuration file. Note that `<zabbix_script_path>` is your Zabbix agent script path :
    
    ```
    EnableRemoteCommands=1
    UnsafeUserParameters=1
    UserParameter=vbr[*],%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -nologo -command "& C:\Zabbix\zabbix\_vbr\_job.ps1" "$1" "$2"
    ```

2. Add a value mapping named `vbrJobResult` with the following values:
   * 0 => Failed
   * 1 => Warning
   * 2 => Success
3. Add a value mapping named `vbrJobRunStatus` with the following values:
   * 0 => Stopped
   * 1 => Running
3. Import **zbx-veeam-backup.xml** file into Zabbix.
4. Add to your host the followed macro with value **{$VEEAM\_MAX\_RUNNING\_JOB}**
5. Associate **ZBX-VEEAM-BACKUP** template to the host.

### Requirements

This template was tested for Zabbix 2.0.0 and higher.

###### [VEEAM Backup and Replication](http://www.veeam.com) 6.0 or higher

License
-------

This template is distributed under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the  License, or (at your option) any later version.

### Copyright

  Copyright (c) Jean-Jacques Martrès

### Authors

  Jean-Jacques Martrès
  (jjmartres |at| gmail |dot| com)
