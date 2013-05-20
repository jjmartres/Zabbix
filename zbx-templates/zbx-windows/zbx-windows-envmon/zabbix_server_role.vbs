strComputer = "."
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colRoleFeatures = objWMIService.ExecQuery ("Select * from Win32_ServerFeature")
For Each objRoleFeatures in colRoleFeatures
    wscript.echo objRoleFeatures.Name
Next