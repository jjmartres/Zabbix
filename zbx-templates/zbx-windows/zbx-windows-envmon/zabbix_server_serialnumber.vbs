strComputer = "."
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colRoleFeatures = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
For Each objRoleFeatures in colRoleFeatures
    wscript.echo objRoleFeatures.SerialNumber
Next


