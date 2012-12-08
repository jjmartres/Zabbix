# Script: Get-DcsPhysicalDisk
# Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
# Description: Query DataCore SANSymphony server and returns the port data for SCSI ports.
#
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#				InitiatorPortals			      :	  {fe80::2de4:e3b4:87d0:b299, fe80::d86e:28b1:6c8e:ee36, fe80::ac9f:4abc:8e7:447a, fe80::f13e:c21d:f0b8:c2e...}
#				iSnsServer				        	:	  {}
#				TargetPortals				        :	  {DataCore.Executive.iScsiTargetPortalData}
#				PresenceStatus				      :	  [Unknown,Present,NotPresent]																								                                          [Enum]::GetValues((Get-DcsPort)[0].PresenceStatus.GetType())
#				PhysicalName				        :	  MSFT-05-1991
#				ServerPortProperties		    :	  DataCore.Executive.ServerPortPropertiesData
#				RoleCapability				      :	  [None, Frontend, Backend, Mirror, All]																						                                    [Enum]::GetValues((Get-DcsPort)[0].RoleCapability.GetType())
#				PortName					          :	  iqn.1991-05.com.microsoft.ssv1.datacoresoftware.com
#				Alias						            :	  Microsoft iSCSI Initiator
#				Description					        :	
#				PortType					          :	  [Unknown, SCSI, FibreChannel, iSCSI, Loopback]																				                                [Enum]::GetValues((Get-DcsPort)[0].PortType.GetType())
#				PortMode					          :	  [NonScsi, Initiator, Target, InitiatorTarget, Unknown]																		                            [Enum]::GetValues((Get-DcsPort)[0].PortMode.GetType())
#				HostId						          :	  A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3
#				Connected					          :	  True
#				Id							            :	  A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3:MSFT-05-1991
#				Caption						          :	  Microsoft iSCSI Initiator
#				ExtendedCaption				      : 	Microsoft iSCSI Initiator on SSV1
#				Internal					          :	  False
#				InitiatorBytesTransferred 	: 	0
#				InitiatorBytesRead        	: 	0
#				InitiatorBytesWritten     	: 	0
#				InitiatorOperations       	: 	141
#				InitiatorReads            	: 	0
#				InitiatorWrites           	: 	0
#				InitiatorReadTime         	: 	0
#				InitiatorWriteTime        	: 	0
#				InitiatorMaxReadTime      	: 	0
#				InitiatorMaxWriteTime     	: 	0
#				TargetBytesTransferred    	: 	91815424
#				TargetBytesRead           	: 	0
#				TargetBytesWritten        	: 	91815424
#				TargetOperations          	: 	6619
#				TargetReads               	: 	0
#				TargetWrites              	: 	6620
#				TargetReadTime            	: 	0
#				TargetWriteTime           	: 	1491
#				TargetMaxReadTime         	: 	0
#				TargetMaxWriteTime        	: 	15
#				PendingInitiatorCommands  	: 	0
#				PendingTargetCommands     	:	  0
#				TotalPendingCommands      	: 	0
#				TotalBytesTransferred     	: 	91815424
#				TotalBytesRead            	: 	0
#				TotalBytesWritten         	: 	91815424
#				TotalOperations           	: 	6760
#				TotalReads                	: 	0
#				TotalWrites               	: 	6620
#				CollectionTime            	: 	26/11/2012 15:21:23
#				NullCounterMap            	: 	0
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command  "& C:\Progra~1\Zabbix\scripts\Get-DcsPort.ps1 <DCS> <DCS_USERNAME> <DCS_PASSWORD> <ITEM_TO_QUERY> <INDEX>"
#	  as an item:		  DcsPort[<DCS>,<DCS_USERNAME>,<DCS_PASSWORD>,<ITEM_TO_QUERY>,<INDEX>]
#
# Add to Zabbix Agent
# 	UserParameter=DcsPort[*],powershell.exe -nologo -command "& C:\Progra~1\Zabbix\scripts\Get-DcsVirtualDisk.ps1 $1 $2 $3 $4 $5"
#
$version = "1.0.0"

# Load SANsymphony-V Cmdlets
$bpKey = 'BaseProductKey'
$regKey = Get-Item "HKLM:\Software\DataCore\Executive"
$strProductKey = $regKey.getValue($bpKey)
$regKey = Get-Item "HKLM:\$strProductKey"
$installPath = $regKey.getValue('InstallPath')

Import-Module "$installPath\DataCore.Executive.Cmdlets.dll" -DisableNameChecking -ErrorAction Stop

$DCS = [string]$args[0]
$DCS_USERNAME = [string]$args[1]
$DCS_PASSWORD = [string]$args[2]
$ITEM = [string]$args[3]
$INDEX = [string]$args[4]

# Connect to DCS Server
Connect-DcsServer -server $DCS -username $DCS_USERNAME -password $DCS_PASSWORD | Out-Null
$connection = Get-DcsConnection
$dcsserver = Get-DcsServer -Connection $connection | Where-Object {$_.IpAddresses -like "*$connection*"}
if ( $connection ) {
	# Query the DCS Server
	switch ($ITEM) {
		"Discovery" {
			# Open JSON object
			$output =  "{`"data`":["
			$query = Get-DcsPort -Connection $connection -Machine $dcsserver.HostName -Type iSCSI,FibreChannel | Select-Object Id, Alias
			$count = $query | Measure-Object
			$count = $count.count
			foreach ($object in $query) {
				$Id = [string]$object.Id
				$Name = [string]$object.Alias
				if ($count -eq 1) {
					$output = $output + "{`"{#PORTID}`":`"$Id`",`"{#PORTNAME}`":`"$Name`"}"
				} else {
					$output = $output + "{`"{#PORTID}`":`"$Id`",`"{#PORTNAME}`":`"$Name`"},"
				}
				$count--
			}
			# Close JSON object
			$output = $output + "]}"
			Write-Host $output
		}
		default {
			if ($ITEM -match "^Perf") {
				$query = Get-DcsPort -Connection $connection -Machine $dcsserver.HostName | Where-Object {$_.Id -like "*$INDEX*"} | Get-DcsPerformanceCounter
				$ITEM = $ITEM.replace('Perf','')
				[string]$query.$ITEM
			} else {
				$query = Get-DcsPort -Connection $connection -Machine $dcsserver.HostName | Where-Object {$_.Id -like "*$INDEX*"}
				if ([string]$query.$ITEM -match "\d+ ([A-Z]B|B)") {
					$query.$ITEM.Value
				} else {
					[string]$query.$ITEM
				}
			}
		}
	}
	Disconnect-DcsServer -connection $connection  | Out-Null
} else {
	Write-Host "-- ERROR -- : Connection error to <$DCS> !"
}
