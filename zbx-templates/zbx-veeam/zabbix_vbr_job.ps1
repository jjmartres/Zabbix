# Script: Get-VBRJob
# Author: Jean-Jacques Martr�s (jjmartres |at| gmail |dot| com)
# Description: Query Veeam job information
# License: GPL2
#
# This script is intended for use with Zabbix > 2.0
#
# RETURNED DATA:
#
#      Id                     : 5e6063aa-49b1-4515-9711-01e6d3083443
#      Name                   : KHP-BCK-JOB-007 - MyJob
#      IsScheduleEnabled      : True
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command  "& C:\Zabbix\zabbix_vbr_job.ps1 <ITEM_TO_QUERY> <JOBID>"
#   as an item:     vbr[<ITEM_TO_QUERY>,<JOBID>]
#
# Add to Zabbix Agent
#   UserParameter=vbr[*],%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -nologo -command "& C:\Zabbix\zabbix_vbr_job.ps1 $1 $2"
#
$version = "1.0.4"

$ITEM = [string]$args[0]
$ID = [string]$args[1]

#* Load Veeam snapin
Add-PsSnapin -Name VeeamPSSnapIn -ErrorAction SilentlyContinue

# Query VEEAM for Job. Include only enabled jobs
switch ($ITEM) {
  "Discovery" {
    # Open JSON object
    $output =  "{`"data`":["
      $query = Get-VBRJob | Where-Object {$_.IsScheduleEnabled -eq "true"} | Select-Object Id,Name, IsScheduleEnabled
      $count = $query | Measure-Object
      $count = $count.count
      foreach ($object in $query) {
        $Id = [string]$object.Id
        $Name = [string]$object.Name
        $Schedule = [string]$object.IsScheduleEnabled
        if ($count -eq 1) {
          $output = $output + "{`"{#JOBID}`":`"$Id`",`"{#JOBNAME}`":`"$Name`",`"{#JOBSCHEDULED}`":`"$Schedule`"}"
        } else {
          $output = $output + "{`"{#JOBID}`":`"$Id`",`"{#JOBNAME}`":`"$Name`",`"{#JOBSCHEDULED}`":`"$Schedule`"},"
        }
        $count--
    }
    # Close JSON object
    $output = $output + "]}"
    Write-Host $output
  }
  "Result"  {
  $query = Get-VBRJob | Where-Object {$_.Id -like "*$ID*" -and $_.IsScheduleEnabled -eq "true"}
    if ($query) {switch ([string]$query.GetLastResult()) {
      "Failed" {
        return "0"
      }
      "Warning" {
        return "1"
      }
      default {
        return "2"
      }

    }
  }
    else {"2"}
  }
  "RunStatus" {
  $query = Get-VBRJob | Where-Object {$_.Id -like "*$ID*"}
  if ($query.IsRunning) { return "1" } else { return "0"}
  }
  "IncludedSize"{
  $query = Get-VBRJob | Where-Object {$_.Id -like "*$ID*"}
  [string]$query.Info.IncludedSize
  }
  "ExcludedSize"{
  $query = Get-VBRJob | Where-Object {$_.Id -like "*$ID*"}
  [string]$query.Info.ExcludedSize
  }
  "VmCount" {
  $query = Get-VBRBackup | Where-Object {$_.JobId -like "*$ID*"}
  [string]$query.VmCount
  }
  "Type" {
  $query = Get-VBRBackup | Where-Object {$_.JobId -like "*$ID*"}
  [string]$query.JobType
  }
  "RunningJob" {
  $query = Get-VBRBackupSession | where { $_.isCompleted -eq $false } | Measure
  if ($query) {
	[string]$query.Count
    } else {
	return "0"
    }
  }
  default {
      Write-Host "-- ERROR -- : Need an option to work !"
  }
}
