Set dtmLastBootUpTime = CreateObject("WbemScripting.SWbemDateTime")
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set objOS = objWMIService.ExecQuery( "Select * from Win32_OperatingSystem")
For Each strOS in objOS
    dtmLastBootUpTime.Value = strOS.LastBootUpTime
    ' WScript.Echo dtmLastBootUpTime.GetVarDate(false)
    WScript.Echo DateDiff("s","01/01/1970 00:00:00", dtmLastBootUpTime.GetVarDate(false))
Next