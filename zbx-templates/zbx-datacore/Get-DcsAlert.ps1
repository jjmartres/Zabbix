# Script: Get-DcsAlert
# Author: Jean-Jacques Martrès (jjmartres |at| gmail |dot| com)
# Description: Query DataCore SANSymphony server to get alert messages.
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#        Id                 :  DataCore.Executive.LogMessageId
#        TimeStamp          :  8/8/2011 6:56:41 PM
#        MachineName        :  SSV1
#        Level              :  [Trace, Info, Warning, Error, Diagnostic]                                                                [Enum]::GetValues((Get-DcsAlert)[0].Level.GetType())
#        Visibility         :  Customer
#        HighPriority       :  True
#        NeedsAcknowledge   :  False
#        MessageText        :  CHECK THE EVENT LOG! A WARNING MESSAGE HAS BEEN RECEIVED. [Triggered by One-Time Scheduler: 8/8/2011
#        2                  :  55:00 PM on 8/8/2011 2:55:00 PM]
#        MessageData        :
#        UserId             :
#        UserName           :
#        Caller             :  MessageAction.DoRun
#        Sources            :  {f9b6dcc0-5c79-42be-ba39-6d44884cb08c}
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command "& C:\Progra~1\Zabbix\scripts\Get-DcsAlert.ps1 <DCS> <DCS_USERNAME> <DCS_PASSWORD> <LEVEL>"
#   as an item:     DcsAlert[<DCS>,<DCS_USERNAME>,<DCS_PASSWORD>,<LEVEL>]
#
# Add to Zabbix Agent
#   UserParameter=DcsAlert[*],powershell.exe -nologo -command "& C:\Progra~1\Zabbix\scripts\Get-DcsServer.ps1 $1 $2 $3 $4"
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
$LEVEL = [string]$args[3]

# Connect to DCS Server
Connect-DcsServer -server $DCS -username $DCS_USERNAME -password $DCS_PASSWORD | Out-Null
$connection = Get-DcsConnection
$dcsserver = Get-DcsServer -Connection $connection | Where-Object {$_.IpAddresses -like "*$connection*"}
if ( $connection ) {
  # Query the DCS Server
  $query = Get-DcsAlert -Connection $connection | Where-Object {$_.Level -like "*$LEVEL*"} | Measure-Object
  $query.count
  Disconnect-DcsServer -connection $connection  | Out-Null
} else {
  Write-Host "-- ERROR -- : Connection error to <$DCS> !"
}
