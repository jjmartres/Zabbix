# Script: Get-DcsServer
# Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
# Description: Query DataCore SANSymphony server to get system, product information and server properties for servers.
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#				GroupId 					          : 	626ad5ae-8297-4068-832c-7c476fe32abf
#				RegionNodeId 				        : 	ExecutiveNode:A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3
#				CacheSize 					        : 	0.00 B
#				State 						          : 	[NotPresent, Offline, Online, Failed]																										                          [Enum]::GetValues((Get-DcsServer)[0].State.GetType())
#				SupportState 				        : 	[NotPresent, Idle, Collecting, Sending, Cancelling, Preserving, CommunicationInterrupted]													[Enum]::GetValues((Get-DcsServer)[0].SupportState.GetType())
#				SnapshotMapStoreId 			    :	 	
#				SnapshotMapStorePoolId 		  : 	
#				InstallPath 				        : 	C:\Program Files\DataCore\SANsymphony
#				ProductName 				        : 	SANsymphony-V
#				ProductType 				        : 	Standard
#				ProductVersion 				      : 	8.1
#				OsVersion 					        : 	Windows Server 2008 R2 x64 Edition, Service Pack 1
#				ProcessorInfo 				      : 	DataCore.Executive.ProcessorInformation
#				ProductBuild 				        : 	13.1.0.798
#				BuildType 					        : 	Release
#				DiagnosticMode 				      : 	[Disabled, Enabled]																															                                   [Enum]::GetValues((Get-DcsServer)[0].DiagnosticMode.GetType())
#				LicenseRemaining 			      : 	23238000000000
#				ReplicationBufferFolder 	  : 	
#				TotalSystemMemory 			    : 	1,023.56 MB
#				AvailableSystemMemory 		  : 	136.08 MB
#				LogStatus 					        : 	[Operational, StoragePaused, StorageFailed, QueueFull, FloodedOperational]																	        [Enum]::GetValues((Get-DcsServer)[0].LogStatus.GetType())
#				LicenseSettings 			      : 	DataCore.Executive.LicenseSettings
#				IsLicensed 					        : 	True
#				StorageUsed 				        : 	0.00 B
#				PowerState 					        : 	[Unknown, ACOffline, ACOnline, BatteryLow]																									                        [Enum]::GetValues((Get-DcsServer)[0].PowerState.GetType())
#				CacheState 					        : 	[Unknown, WritethruGlobal, WritebackGlobal]																									                        [Enum]::GetValues((Get-DcsServer)[0].CacheState.GetType())
#				BackupStorageFolder 		    : 	
#				IpAddresses 				        : 	{172.20.17.63, fe80::ac9f:4abc:8e7:447a, 13.0.0.31, fe80::2de4:e3b4:87d0:b299...}
#				Description 				        : 	
#				HostName 					          : 	SSV1.datacoresoftware.com
#				Id 							            : 	A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3
#				Caption 					          : 	SSV1
#				ExtendedCaption 			      : 	SSV1 in Server Group
#				Internal 					          : 	False
#				InitiatorBytesRead          : 	28970653935104
#				InitiatorBytesWritten       : 	27149971772928
#				InitiatorOperations         : 	3464521659
#				InitiatorReads              : 	601757968
#				InitiatorWrites             : 	1513626899
#				TargetBytesTransferred      : 	82750114543104
#				TargetBytesRead             : 	62994671409664
#				TargetBytesWritten          : 	19755443133440
#				TargetOperations            : 	1994065894
#				TargetReads                 : 	1260477288
#				TargetWrites                : 	1416916790
#				TotalBytesMigrated          : 	0
#				CacheSize                   : 	24749539328
#				FreeCache                   : 	24732528640
#				CacheReadHits               : 	1021689344
#				CacheReadMisses             : 	479998219
#				CacheWriteHits              : 	3173403439
#				CacheWriteMisses            : 	15930737664
#				CacheReadHitBytes           : 	34550148509184
#				CacheReadMissBytes          : 	22743527423488
#				CacheWriteHitBytes          : 	48462461228544
#				CacheWriteMissBytes         : 	82241206560256
#				SupportRemainingBytesToSend : 	0
#				SupportBytesSent            : 	0
#				SupportPercentTransferred   : 	0
#				TotalBytesTransferred       : 	138870740251136
#				TotalBytesRead              : 	91965325344768
#				TotalBytesWritten           : 	46905414906368
#				TotalOperations             : 	4792778945
#				TotalReads                  : 	1862235256
#				TotalWrites                 : 	2930543689
#				CollectionTime              : 	26/11/2012 09:03:25
#				NullCounterMap              : 	0
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command "& C:\Progra~1\Zabbix\scripts\Get-DcsServer.ps1 <DCS> <DCS_USERNAME> <DCS_PASSWORD> <ITEM_TO_QUERY>"
#   as an item:		  DcsServer[<DCS>,<DCS_USERNAME>,<DCS_PASSWORD>,<ITEM_TO_QUERY>]
#
# Add to Zabbix Agent
# 	UserParameter=DcsServer[*],powershell.exe -nologo -command "& C:\Progra~1\Zabbix\scripts\Get-DcsServer.ps1 $1 $2 $3 $4"
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

# Connect to DCS Server
Connect-DcsServer -server $DCS -username $DCS_USERNAME -password $DCS_PASSWORD | Out-Null
$connection = Get-DcsConnection
$dcsserver = Get-DcsServer -Connection $connection | Where-Object {$_.IpAddresses -like "*$connection*"}
if ( $connection ) {
	# Query the DCS Server
	switch ($ITEM) {
		"TotalSystemMemory" {
			$query = get-wmiobject win32_computersystem
			[string]$query.TotalPhysicalMemory
		}
		"AvailableSystemMemory" {
			$query = get-wmiobject win32_operatingsystem
			[string]$query.FreePhysicalMemory
		}
		"TotalVirtualDisk" {
			$query = Get-DcsVirtualDisk -Connection $connection -Server $dcsserver.HostName | Where-Object { $_.IsServed -like "TRUE" } | Measure-Object
			$query.Count
		}
		default {
			if ($ITEM -match "^Perf") {
				$query = Get-DcsServer -Connection $connection | Where-Object {$_.IpAddresses -like "*$connection*"} | Get-DcsPerformanceCounter
				$ITEM = $ITEM.replace('Perf','')
				[string]$query.$ITEM
			} else {
				$query = Get-DcsServer -Connection $connection | Where-Object {$_.IpAddresses -like "*$connection*"}
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
