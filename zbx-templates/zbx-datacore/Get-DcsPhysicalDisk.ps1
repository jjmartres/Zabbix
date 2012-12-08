# Script: Get-DcsPhysicalDisk
# Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
# Description: Query DataCore SANSymphony server and returns data for physical disks
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#				PoolMemberId 			      : 	20394e04-6134-4ddf-8663-1176e851d27d
#				HostId 					        : 	A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3
#				PresenceStatus 			    : 	[Unknown, Present, NotPresent]															 										                                              [Enum]::GetValues((Get-DcsPhysicalDisk)[0].PresenceStatus.GetType())
#				Size 					          : 	50.00 GB
#				FreeSpace 				      : 	0.00 B
#				InquiryData 			      : 	DataCore SANmelody DCS VVol3_SSV1_50
#				ScsiPath 				        : 	Port 4, Bus 0, Target 4, LUN 0
#				DiskIndex 				      : 	1
#				SystemName 				      : 	
#				DiskHealth 				      : 	Healthy
#				BusType 				        : 	[Unknown, Scsi, Atapi, Ata, Type1394, Ssa, Fibre, Usb, RAID, Scsi, Sas, Sata, Sd, Mmc, Max, FileBackedVirtual, MaxReserved]		[Enum]::GetValues((Get-DcsPhysicalDisk)[0].BusType.GetType())
#				Type 					          : 	[Basic, Dynamic, Uninitialized, Pool, PassThrough, MirrorDisk, Unknown]															                          [Enum]::GetValues((Get-DcsPhysicalDisk)[0].Type.GetType())
#				DiskStatus 				      : 	[Unknown, Online, NotReady, NoMedia, Offline, Failed ,Missing]																	                              [Enum]::GetValues((Get-DcsPhysicalDisk)[0].DiskStatus.GetType())
#				Partitioned 			      : 	True				
#				InUse 					        : 	True
#				IsBootDisk 				      : 	False
#				Protected 				      : 	False
#				UniqueIdentifier 		    : 	naa.60030d9056566f6c335f535356315f35
#				Id 						          : 	A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3:naa.60030d9056566f6c335f535356315f35
#				Caption 				        : 	Disk 1
#				ExtendedCaption 		    : 	Disk 1 on SSV1
#				Internal 				        : 	False
#				TotalReadsTime        	: 	286595
#				TotalWritesTime       	: 	202683
#				TotalPendingCommands  	: 	0
#				TotalReads            	: 	60814
#				TotalWrites           	: 	193226
#				TotalOperations       	: 	254040
#				TotalBytesRead        	: 	1583401472
#				TotalBytesWritten     	: 	6104131584
#				TotalBytesTransferred 	: 	7687533056
#				CollectionTime        	: 	26/11/2012 16:03:08
#				NullCounterMap        	:	  0
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command  "& C:\Progra~1\Zabbix\scripts\Get-DcsPhysicalDisk.ps1 <DCS> <DCS_USERNAME> <DCS_PASSWORD> <ITEM_TO_QUERY> <INDEX>"
#	  as an item:		  DcsPhysicakDisk[<DCS>,<DCS_USERNAME>,<DCS_PASSWORD>,<ITEM_TO_QUERY>,<INDEX>]
#
# Add to Zabbix Agent
# 	UserParameter=DcsPhysicalDisk[*],powershell.exe -nologo -command "& C:\Progra~1\Zabbix\scripts\Get-DcsPhysicalDisk.ps1 $1 $2 $3 $4 $5"
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
			$query = Get-DcsPhysicalDisk -Connection $connection -Server $dcsserver.HostName -Type PoolDisk | Select-Object UniqueIdentifier, Caption
			$count = $query | Measure-Object
			$count = $count.count
			foreach ($object in $query) {
				$Id = [string]$object.UniqueIdentifier
				$Name = [string]$object.Caption
				if ($count -eq 1) {
					$output = $output + "{`"{#DISKID}`":`"$Id`",`"{#DISKNAME}`":`"$Name`"}"
				} else {
					$output = $output + "{`"{#DISKID}`":`"$Id`",`"{#DISKNAME}`":`"$Name`"},"
				}
				$count--
			}
			# Close JSON object
			$output = $output + "]}"
			Write-Host $output
		}
		"PoolMember" {
			$query = Get-DcsPhysicalDisk -Connection $connection -Server $dcsserver.HostName -Type PoolDisk | Where-Object {$_.UniqueIdentifier -like "*$INDEX*"}
			$PoolMemberId = [string]$query.PoolMemberId
			$query = Get-DcsPoolMember -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Id -like "*$PoolMemberId*"}
			$DiskPoolId = string]$query.DiskPoolId
			$query = Get-DcsPool -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Id -like "*$DiskPoolId*"}
			[string]$query.Alias			
		}
		"DiskTier" {
			$query = Get-DcsPhysicalDisk -Connection $connection -Server $dcsserver.HostName -Type PoolDisk | Where-Object {$_.UniqueIdentifier -like "*$INDEX*"}
			$PoolMemberId = [string]$query.PoolMemberId
			$query = Get-DcsPoolMember -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Id -like "*$PoolMemberId*"}
			[string]$query.DiskTier
		}
		default {
			if ($ITEM -match "^Perf") {
				$query = Get-DcsPhysicalDisk -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.UniqueIdentifier -like "*$INDEX*"} | Get-DcsPerformanceCounter
				$ITEM = $ITEM.replace('Perf','')
				[string]$query.$ITEM
			} else {
				$query = Get-DcsPhysicalDisk -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.UniqueIdentifier -like "*$INDEX*"}
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
