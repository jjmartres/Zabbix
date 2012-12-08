# Script: Get-DcsPhysicalDisk
# Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
# Description: Query DataCore SANSymphony server and returns data for virtual disks
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#				VirtualDiskGroupId			    :	
#				FirstHostId					        :	  A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3
#				SecondHostId				        :	
#				BackupHostId				        :	
#				StorageProfileId			      :	  100469DF-0BE1-40DA-874E-9F1DA5A259E3
#				Alias						            :	  Virtual disk 1 @ 8/11/2011 5:07:01 PM
#				Description					        :	
#				Size						            :	  50.00 GB
#				Type						            :	  [NonMirrored, MultiPathMirrored,Dual]																																	                                                            [Enum]::GetValues((Get-DcsVirtualDisk)[0].Type.GetType())
#				DiskStatus					        :	  [Online, Offline, FailedRedundancy, Failed, Unknown]																													                                                    [Enum]::GetValues((Get-DcsVirtualDisk)[0].DiskStatus.GetType())
#				InquiryData					        :	  DataCore Virtual Disk DCS
#				ScsiDeviceId				        :	  {96, 3, 13, 144...}
#				RemovableMedia				      :	  False
#				WriteThrough				        :	  False
#				Offline						          :	  False
#				DiskLayout					        :	  DataCore.Executive.PhysicalDiskLayout
#				PersistentReserveEnabled	  :	  True
#				RecoveryPriority			      :	  [Low, Regular, High, Critical]																																			                                                              [Enum]::GetValues((Get-DcsVirtualDisk)[0].RecoveryPriority.GetType())
#				IsServed					          :	  True
#				Id							            :	  485f20b6b4ad47abab73cadbc84d3564
#				Caption						          :	  Virtual disk 1 @ 8/11/2011 5:07:01 PM
#				ExtendedCaption				      :	  Virtual disk 1 @ 8/11/2011 5:07:01 PM from Local
#				Internal					          :	  False
#				FirstRecovery       		    : 	[NoRecoveryNeeded, LogRecoveryNeeded, FullRecoveryNeeded, LogRecoveryPending, FullRecoveryPending, InLogRecovery, InFullRecovery, Undefined, DoubleFailure]				[Enum]::GetValues((Get-DcsMirror)[0].FirstRecovery.GetType())
#				SecondRecovery      		    : 	[NoRecoveryNeeded, LogRecoveryNeeded, FullRecoveryNeeded, LogRecoveryPending, FullRecoveryPending, InLogRecovery, InFullRecovery, Undefined, DoubleFailure]				[Enum]::GetValues((Get-DcsMirror)[0].SecondRecovery.GetType())
#				TotalBytesTransferred      	: 	281282048
#				TotalBytesRead             	:	  140379648
#				TotalBytesWritten          	: 	140902400
#				TotalBytesMigrated         	: 	0
#				TotalReads                 	: 	1075
#				TotalWrites                	: 	1083
#				TotalOperations            	: 	2149
#				CacheReadHits              	: 	1
#				CacheReadMisses            	: 	1073
#				CacheWriteHits             	: 	0
#				CacheWriteMisses           	: 	1083
#				CacheReadHitBytes          	: 	512
#				CacheReadMissBytes         	: 	140379136
#				CacheWriteHitBytes         	: 	0
#				CacheWriteMissBytes        	: 	140902400
#				ReplicationBytesSent       	: 	0
#				ReplicationBytesToSend     	: 	0
#				ReplicationTimeLag         	: 	0
#				InitializationPercentage   	: 	0
#				TestModeProgressPercentage 	: 	0
#				CollectionTime             	:	  26/11/2012 15:22:11
#				NullCounterMap             	: 	0
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command  "& C:\Progra~1\Zabbix\scripts\Get-DcsVirtualDisk.ps1 <DCS> <DCS_USERNAME> <DCS_PASSWORD> <ITEM_TO_QUERY> <INDEX>"
#	  as an item:		  DcsVirtualDisk[<DCS>,<DCS_USERNAME>,<DCS_PASSWORD>,<ITEM_TO_QUERY>,<INDEX>]
#
# Add to Zabbix Agent
# 	UserParameter=DcsVirtualDisk[*],powershell.exe -nologo -command "& C:\Progra~1\Zabbix\scripts\Get-DcsVirtualDisk.ps1 $1 $2 $3 $4 $5"
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
			$query = Get-DcsVirtualDisk -Connection $connection -Server $dcsserver.HostName | Select-Object Id, Alias
			$count = $query | Measure-Object
			$count = $count.count
			foreach ($object in $query) {
				$Id = [string]$object.Id
				$Name = [string]$object.Alias
				if ($count -eq 1) {
					$output = $output + "{`"{#VDID}`":`"$Id`",`"{#VDNAME}`":`"$Name`"}"
				} else {
					$output = $output + "{`"{#VDID}`":`"$Id`",`"{#VDNAME}`":`"$Name`"},"
				}
				$count--
			}
			# Close JSON object
			$output = $output + "]}"
			Write-Host $output
		}
		"MirrorStatus" {
			$vd = Get-DcsVirtualDisk -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Id -like "*$INDEX*"}
			if ( $vd.Type -match "NonMirrored" ) {
				[string]$vd.Type
			} else {
        $query = Get-DcsMirror  -Connection $connection -VirtualDisk $INDEX
				if ( $vd.FirstHostId -eq $dcsserver.Id ) {
					[string]$query.FirstRecovery
				} else {
					[string]$query.SecondRecovery
				}
			}
		}
		default {
			$query = Get-DcsVirtualDisk -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Id -like "*$INDEX*"}
			if ($ITEM -match "^Perf") {
				$query = Get-DcsVirtualDisk -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Id -like "*$INDEX*"} | Get-DcsPerformanceCounter
				$ITEM = $ITEM.replace('Perf','')
				[string]$query.$ITEM
			} elseif ($ITEM -match "HostId") {
				$query = Get-DcsServer -Connection $connection | Where-Object {$_.Id -like $query.$ITEM }
				[string]$query.Caption			
			} elseif ([string]$query.$ITEM -match "\d+ ([A-Z]B|B)") {
				$query.$ITEM.Value
			} else {
				[string]$query.$ITEM
			}
		}		
	}
	Disconnect-DcsServer -connection $connection  | Out-Null
} else {
	Write-Host "-- ERROR -- : Connection error to <$DCS> !"
}
