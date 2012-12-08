# Script: get.DcsPoolDisk
# Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
# Description: Query DataCore SANSymphony server and returns data for disk pools
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#				ServerId 					           : 	A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3
#				Alias 						           : 	Disk pool 1
#				Description 				         : 	
#				PresenceStatus 				       : 	[Unknown, Present, NotPresent]																				                [Enum]::GetValues((Get-DcsPool)[0].PresenceStatus.GetType())
#				PoolStatus 					         : 	[Running, Initializing, MissingDisks, Foreign, Offline, Unknown]											[Enum]::GetValues((Get-DcsPool)[0].PoolStatus.GetType())
#				Type 						             : 	[Dynamic, Static, NonInitialize, Unknown]																	            [Enum]::GetValues((Get-DcsPool)[0].Type.GetType())
#				ChunkSize 					         : 	128.00 MB
#				MaxTierNumber 				       : 	3
#				Id 							             : 	A6EA4E77-BBFF-4F48-91CD-3987E81C1CB3:{ea7c7a80-bdf3-11e0-8304-00155d11e921}
#				Caption 					           : 	Disk pool 1
#				ExtendedCaption 			       : 	Disk pool 1 on SSV1
#				Internal 					           : 	False
#				TotalBytesTransferred        :  117991668408320
#				TotalBytesRead               :  64774275351040
#				TotalBytesWritten            :  53217425588736
#				TotalBytesMigrated           :  0
#				TotalReads                   :  943129892
#				TotalWrites                  :  3197418524
#				TotalOperations              :  4140547577
#				BytesAllocated               :  30385283006464
#				BytesAvailable               :  11937190510592
#				BytesInReclamation           :  0
#				BytesTotal                   :  44354395701248
#				PercentAllocated             :  74
#				PercentAvailable             :  26
#				TotalReadTime                :  15142325219
#				TotalWriteTime               :  19396791451
#				MaxReadTime                  :  31
#				MaxWriteTime                 :  140
#				MaxReadWriteTime             :  140
#				MaxPoolBytes                 :  1112551148486656
#				BytesReserved                :  2031922184192
#				BytesAllocatedPercentage     :  70
#				BytesReservedPercentage      :  4
#				BytesInReclamationPercentage :  0
#				BytesAvailablePercentage     :  26
#				BytesOverSubscribed          :  6656930873344
#				CollectionTime               :  26/11/2012 14:58:35
#				NullCounterMap               :  0
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command  "& C:\Progra~1\Zabbix\scripts\Get-DcsPoolDisk.ps1 <DCS> <DCS_USERNAME> <DCS_PASSWORD> <ITEM_TO_QUERY> <INDEX>"
#	  as an item:		  DcsPoolDisk[<DCS>,<DCS_USERNAME>,<DCS_PASSWORD>,<ITEM_TO_QUERY>,<INDEX>]
#
# Add to Zabbix Agent
# 	UserParameter=DcsPoolDisk[*],powershell.exe -nologo -command "& C:\Progra~1\Zabbix\scripts\Get-DcsPoolDisk.ps1 $1 $2 $3 $4 $5"
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
			$query = Get-DcsPool -Connection $connection -Server $dcsserver.HostName | Select-Object Id, Alias
			$count = $query | Measure-Object
			$count = $count.count
			foreach ($object in $query) {
				$Id = [string]$object.Id
				$Alias = [string]$object.Alias
				if ($count -eq 1) {
					$output = $output + "{`"{#POOLID}`":`"$Id`",`"{#POOLALIAS}`":`"$Alias`"}"
				} else {
					$output = $output + "{`"{#POOLID}`":`"$Id`",`"{#POOLALIAS}`":`"$Alias`"},"
				}
				$count--
			}
			# Close JSON object
			$output = $output + "]}"
			Write-Host $output
		}
		"CountPhysicalDisk" {
			$query = Get-DcsPhysicalDisk -Connection $connection -Server $dcsserver.HostName -Type PoolDisk | Measure-Object
			$query.count
		}
		default {
			if ($ITEM -match "^Perf") {
				$query = Get-DcsPool -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Alias -like "*$INDEX*"} | Get-DcsPerformanceCounter
				$ITEM = $ITEM.replace('Perf','')
				[string]$query.$ITEM
			} else {
				$query = Get-DcsPool -Connection $connection -Server $dcsserver.HostName | Where-Object {$_.Alias -like "*$INDEX*"}
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
