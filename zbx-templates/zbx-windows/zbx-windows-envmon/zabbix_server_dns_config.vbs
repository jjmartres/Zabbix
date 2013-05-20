On Error Resume Next

'Bind to Shell
Set objShell = WScript.CreateObject("WScript.Shell")

'Read Servers NetbiosName
'strComputer = objShell.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ComputerName")

strComputer = "Computer Name!"
wscript.echo strComputer

Set objWMIService = GetObject("winmgmts:" _
 & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colNicConfigs = objWMIService.ExecQuery _
 ("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
 
For Each objNicConfig In colNicConfigs
	If Not IsNull(objNicConfig.DNSServerSearchOrder) Then
		For Each strDNSServer In objNicConfig.DNSServerSearchOrder
			wscript.echo strDNSServer
		Next
	End If
Next