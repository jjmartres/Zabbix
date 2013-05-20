Set wshShell = WScript.CreateObject( "WScript.Shell" )
strUserDomain = wshShell.ExpandEnvironmentStrings( "%USERDOMAIN%" )
WScript.Echo strUserDomain