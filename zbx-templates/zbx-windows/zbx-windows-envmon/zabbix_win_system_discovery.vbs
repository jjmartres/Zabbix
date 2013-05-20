'2013.05.13
'added IP address and MAC address in NIC discovery

'2012.07.11
'added windows modules installed and shell hardware detection to excluded services
'added special exception for clr_optimization services

'2012.06.29
'modified logic for disk discovery (perfcounters are now enumerated and matched)

'2012.06.19
'added exception for SQLAgent in service discovery

'2012.06.15
'fixed formatting bug in disk discovery dskvols
'added process discovery

'2012.06.14.2
'added clr_optimization_v4.0.30319_64/23 services to exclusion list

'2012.06.14.1
'added escape check for \ in makejson

'2012.06.14
'added quota discovery
'added checknativebitness to diskpart sections
'small fix in tabletoarray

'2012.06.07.1
'added network adapter discovery
'added double quote escapeing in makejson
'increased volume discovery diskpart timeout to 30s

'2012.06.07
'increased timeout for diskpart to 15s

'2012.06.06.5
'added logical cpu discovery

'2012.06.06.4
'fixed but in getexeoutput, strstd now gets set to ""

'2012.06.06.3
'fixed bug with excepted services
'counter is used in service discovery to avoid empty json entries
'added raid capable volume discovery

'2012.06.06.2
'added wlms to the list of excepted services
'added sppsvc to the list of excepted services
'service display names are now regulated to make same name services on 2003/2008 have the same displayname

'2012.06.06.1
'moved service discovery here

'2012.06.06
'added smart capable disks discovery

'2012.05.31.1
'removed replace of collection objects "|" to "`"
'makejson strsplit error check

'2012.05.31
'minor formatting change

'2012.05.30
'replaced ^ with | as sepparator

'2012.05.29



Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 
strCurPath = objFSO.GetParentFolderName(WScript.ScriptFullName)



'OPTIONS
OPT_VOLUMES  = "VOLUMES"
OPT_DISKS    = "DISKS"
OPT_SERVICES = "SERVICES"
OPT_CPUS     = "CPUS"
OPT_NICS     = "NICS"
OPT_QUOTAS   = "QUOTAS"
OPT_PROCESSES  = "PROCESSES"

'VOLUME PROPS
PROP_VOLNAME  = 0
PROP_VOLTYPE  = 1
PROP_VOLFS    = 2
PROP_VOLLABEL = 3
PROP_VOLRAID  = 4
PROPNAME_VOLNAME    = "VOLNAME"
PROPNAME_VOLTYPE    = "VOLTYPE"
PROPNAME_VOLFS      = "VOLFS"
PROPNAME_VOLLABEL   = "VOLLABEL"
PROPNAME_VOLRAID    = "VOLRAID"

'DISK PROPS
PROP_DSKNAME  = 0
PROP_DSKNO    = 1
PROP_DSKVOLS  = 2
PROP_DSKLABEL = 3
PROP_DSKSMART = 4
PROPNAME_DSKNAME    = "DSKNAME"
PROPNAME_DSKNO      = "DSKNO"
PROPNAME_DSKVOLS    = "DSKVOLS"
PROPNAME_DSKLABEL   = "DSKLABEL"
PROPNAME_DSKSMART   = "DSKSMART"

'SERVICES PROPS
PROP_SVCNAME      = 0
PROP_SVCSTARTMODE = 1
PROP_SVCDISPNAME  = 2
PROPNAME_SVCNAME       = "SVCNAME"
PROPNAME_SVCSTARTMODE  = "SVCSTARTMODE"
PROPNAME_SVCDISPNAME   = "SVCDISPNAME"

'CPU PROPS
PROP_CPUNO      = 0
PROPNAME_CPUNO       = "CPUNO"

'NIC PROPS
PROP_NICNAME    = 0
PROP_NICDEV     = 1	'THE ACTUAL DEVICE NAME, NOT NUMBERED
PROP_NICDEVNUM  = 2 'THE DEVICE NAME, NUMBERED TO BE UNIQUE
PROP_NICPERF    = 3 'THE PERFCOUNTER INSTANCE NAME
PROP_NICMAC     = 4
PROP_NICSTATE   = 5
PROP_NICADDR	= 6
PROPNAME_NICNAME     = "NICNAME"
PROPNAME_NICDEV      = "NICDEV"
PROPNAME_NICDEVNUM   = "NICDEVNUM"
PROPNAME_NICPERF     = "NICPERF"
PROPNAME_NICMAC      = "NICMAC"
PROPNAME_NICSTATE    = "NICSTATE"
PROPNAME_NICADDR	 = "NICADDR"

'QUOTA
PROP_QUPATH   = 0
PROP_QUSTATUS = 1
PROPNAME_QUPATH   = "QUPATH"
PROPNAME_QUSTATUS = "QUSTATUS"

'PROCESS
PROP_PRNAME   = 0
PROP_PRSIZE   = 1
PROPNAME_PRNAME   = "PRNAME"
PROPNAME_PRSIZE   = "PRSIZE"  '10, 25, 50, 100, 250, 500, 1000, Higher




'CHECK ARGUMENTS
Function CheckArguments(expArgs)
On Error Resume Next

	If (WScript.Arguments.Count < expArgs) Then
		'ERROR
		Call WScript.echo("Not enough arguments (" & WScript.Arguments.Count & "/" & expArgs & ").")
		
		'QUIT
		WScript.Quit		
	End If
End Function


'CHECK NATIVE BITNESS
Function CheckNativeBitness
On Error Resume Next

	Set objProcEnv = objShell.Environment("Process")

	'GET PROCESS BITNESS
    strProcessBit = objProcEnv("PROCESSOR_ARCHITECTURE")
    strProcessorBit = objProcEnv("PROCESSOR_ARCHITEW6432")
    
	'RUNNING IN WOW6432
	If (Len(strProcessorBit) > 0) Then
		'ERROR
		Call WScript.echo("This process must be run in native mode, outside wow64.")
		
		'QUIT
		WScript.Quit			
	End If
End Function


'MAKE JSON
Function MakeJSON(arrPairs, PairCount)
	strStart = "{" & vbCrLf & _
			   "	" & Chr(34) & "data" & Chr(34) & ":" & vbCrLf & _
			   "	" & "[" & vbCrLf
	strEnd   = "	" & "]" & vbCrLf & _
			   "}"
	strPropStart = "		" & "{" & vbCrLf 
	strPropEnd   = "		" & "}" 
	
	'START
	MakeJSON = strStart

	'EACH PAIR
	For x = 0 To PairCount - 1 
		MakeJSON = MakeJSON & strPropStart
		
		'EACH PROP
		For y = 0 To UBound(arrPairs)			
			strSplit = Split(arrPairs(y, x), "|")
			
			'VALID
			If (UBound(strSplit) > 0) Then						
				'NAME AND VALUE 
				strName = Replace(Replace(Replace(strSplit(0), "`", "|"), Chr(34), "\" & Chr(34)), "\", "\\")
				strValue = Replace(Replace(Replace(strSplit(1), "`", "|"), Chr(34), "\" & Chr(34)), "\", "\\")
				'MAKE
				MakeJSON = MakeJSON & "			" & Chr(34) & "{#" & strName & "}" & Chr(34) & ":" & Chr(34) & strValue & Chr(34)
				'COMMA IF NOT LAST
				If (y < UBound(arrPairs)) Then MakeJSON = MakeJSON & ","
				'NEWLINE
				MakeJSON = MakeJSON & vbCrLf
			End If
		Next
				   	
		MakeJSON = MakeJSON & strPropEnd
		'COMMA IF NOT LAST
		If (x < PairCount - 1) Then MakeJSON = MakeJSON & ","
		'NEWLINE
		MakeJSON = MakeJSON & vbCrLf		
	Next
	
	'END
	MakeJSON = MakeJSON & strEnd	
End Function


'GET EXE OUTPUT
Function GetExeOutput(strExe, ByRef strStd, Timeout, ByRef DidTimeout)
On Error Resume Next

	'RESULT
	GetExeOutput = False
	DidTimeout = False
	strStd = ""
	
	'ERR CLEAR
	Err.Clear
	
	Set objExec = objShell.Exec(strExe)
	
	'ERR CHECK
	If (Err.Number = 0) Then
		'SLEEP TO ALLOW PIPES TO CONNECT
		Call WScript.Sleep(100)		
	
		Call objExec.StdIn.Close
		Call objExec.StdErr.Close
		StartDate = Now
		
		'WAIT FOR IT TO FINISH OR TIMEOUT
		Do Until ((objExec.Status = 1) And (objExec.StdOut.AtEndOfStream)) Or (DateDiff("s", StartDate, Now) > TimeOut)
			'STDOUT
			If (Not objExec.StdOut.AtEndOfStream) Then
				strRead = objExec.StdOut.ReadLine
				If (Len(strRead) > 0) Then 
					'#DEBUG
					'Call WScript.Echo(strRead)				
					strStd = strStd & strRead & vbCrLf
				End If
			End If
		Loop
			
		'TIMEOUT
		If (DateDiff("s", StartDate, Now) > TimeOut) Then		
			'TERMINATE PROCESS
			Call objExec.Terminate
			'TIMED OUT
			DidTimeout = True			
		'SUCCESS
		Else
			'RESULT
			GetExeOutput = True		
		End If
	End If
End Function


'TABLE TO ARRAY
Function TableToArray(strTable, strTop, strBottom, arrTable, ByRef RowCount, RemoveSepparator)
	'RESULT
	TableToArray = False
	Dim arrColIndex()		
	top = -1
	bottom = -1	

	'POOR-MAN-REGEX
	strSplit = Split(strTable, vbCrLf)
	
	'FIND TOP
	If (Len(strTop) > 0) Then
		For x = 0 To UBound(strSplit) 
			If (InStr(1, strSplit(x), strTop, 1) > 0) Then top = x + 1
		Next
	Else
		top = 0
	End If
	'SEPPARATOR
	If (RemoveSepparator) Then top = top + 1
	
	'BOUNDS
	If (top > -1) Then		
		'FIND BOTTOM
		If (Len(strBottom) > 0) Then
			For x = top To UBound(strSplit) 
				If (InStr(1, strSplit(x), strBottom, 1) > 0) Then bottom = x - 1
			Next	
		Else
			bottom = UBound(strSplit)
		End If
	End If
		
	'BOUNDS
	If (top > -1) And (bottom > -1) Then
		'GET ROWS
		RowCount = bottom - top + 1
		ColCount = 0
		
		'GET COLS				
		x = 1
		strCols = Trim(strSplit(top - 1))		
		Do While (x < Len(strCols))
			'HEADER FOUND
			If (Mid(strCols, x, 1) <> " ") Then
				'UPDATE COLCOUNT AND COLINDEX
				ColCount = ColCount + 1
				ReDim Preserve arrColIndex(ColCount - 1)
				arrColIndex(ColCount - 1) = x
							
				'WALK THE HEADER
				Do While (Mid(strCols, x, 1) <> " ") And (x < Len(strCols))
					'INC
					x = x + 1
				Loop
			End If			
			'INC
			x = x + 1							
		Loop
			
		'BOUNDS
		If (ColCount > 0) And (RowCount > 0) Then		
			'RESULT
			TableToArray = True
			
			'SET TABLE
			ReDim arrTable(ColCount - 1, RowCount - 1)

			'EACH ROW
			For x = 0 To RowCount - 1
				'EACH COLUMN
				For y = 0 To UBound(arrTable)
					start = arrColIndex(y)
					stopx = 1000
					'NOT LAST ROW
					If (y < ColCount - 1) Then stopx = arrColIndex(y + 1) - 1
					
					arrTable(y, x) = Trim(Mid(strSplit(top + x), start, stopx - start))
				Next
			Next		
		End If
	End If
End Function


'LIST TO ARRAY
Function ListToArray(strList, strTop, arrList, arrTable, ByRef RowCount)
	'RESULT
	ListToArray = False
	top = -1
	bottom = -1	

	'POOR-MAN-REGEX
	strSplit = Split(strList, vbCrLf)	
	
	'FIND TOP
	If (Len(strTop) > 0) Then
		For x = 0 To UBound(strSplit) 
			If (InStr(1, strSplit(x), strTop, 1) > 0) Then top = x
		Next
	End If	

	'BOUNDS
	If (top > -1) Then
		'GET ROWS
		RowCount = 0
		ColCount = UBound(arrList) + 2 'STRTOP + LIST OF PROPS
		'RESULT
		ListToArray = True				
	
		Do 
			'FIND NEXT TOP
			For top = bottom + 1 To UBound(strSplit)
				'FOUND
				If (InStr(1, strSplit(top), strTop, 1) > 0) Then
					'FIND NEXT BOTTOM
					For x = top + 1 To UBound(strSplit)
						'FOUND
						If (InStr(1, strSplit(x), strTop, 1) > 0) Then
							bottom = x - 1
							Exit For
						End If
					Next
					
					'NEVER FOUND, BOTTOM IS END OF LIST
					If (x = UBound(strSplit) + 1) Then bottom = UBound(strSplit)
					
					'SET TABLE
					RowCount = RowCount + 1
					ReDim Preserve arrTable(ColCount - 1, RowCount - 1)
					
					'STRTOP COL POOR-MAN-REGEX
					strSplit1 = Split(strSplit(top), strTop)
					'SET THE COL VALUE
					If (UBound(strSplit1) > 0) Then arrTable(0, RowCount - 1) = Trim(strSplit1(1))
					
					'EACH LINE FROM TOP+1 TO BOTTOM
					For z = top + 1 To bottom 					
						'EACH PROP IN ARRLIST
						For y = 0 To UBound(arrList)
							'ARRLIST COL POOR-MAN-REGEX
							strSplit1 = Split(strSplit(z), arrList(y))
							'SET THE COL VALUE
							If (UBound(strSplit1) > 0) Then arrTable(y + 1, RowCount - 1) = Trim(strSplit1(1))					
						Next
					Next
														
					'STOP SEARCH
					Exit For
				End If
			Next
		
		'UNTIL END OF LIST		
		Loop Until (bottom = UBound(strSplit))
	End If
End Function


'DICTIONARY TO ARRAY
Function DictionaryToArray(objDict, arr, ByRef RowCount)
	'SET ARRAY
	ReDim arr(1, objDict.Count - 1)
	
	'GET ROWS
	RowCount = objDict.Count - 1
	
	'EACH ITEM/KEY
	colItems = objDict.Items
	colKeys = objDict.Keys
	For x = 0 To objDict.Count - 1
		'SET ARRAY
		arr(0, x) = colKeys(x)
		arr(1, x) = colItems(x)
	Next
End Function


'SORT ARRAY
Function SortArray(arr, sortIndex, RowCount)
	'BUBBLE SORT
	For a = RowCount - 1 To 0 Step -1
	    For j = 0 To a	    
	    	'SORT BY SORTINDEX
	        If (CDbl(arr(sortIndex, j)) < CDbl(arr(sortIndex, j + 1))) Then
	        	'SWITCH ALL FIELDS
	        	For y = 0 To UBound(arr)	        	
	            	temp = arr(y, j + 1)
	            	arr(y, j + 1) = arr(y, j)
	            	arr(y, j) = temp
	            Next
	        End If	        
	    Next
	Next 	
End Function




'ARGUMENTS
' 0 : OPTION = [VOLUMES, DISKS, SERVICES, CPUS, NICS, QUOTAS]

'CHECK ARGUMENTS
Call CheckArguments(1)

'GET ARGUMENTS
strOption = WScript.Arguments(0)




'GET VOLUMES
If (StrComp(strOption, OPT_VOLUMES, 1) = 0) Then
	
	'CHECK NATIVE BITNESS
	Call CheckNativeBitness	
	
	'DEFINE JSON PAIRS
	Dim VolPairs()	'VOLNAME, VOLTYPE, VOLFS, VOLLABEL, VOLRAID
	
	'TABLEARR
	Dim arrTable()	
	
	'USE DISKPART
	strExe = "%comspec%" 
	strExeArguments = "/c echo list volume |" & " " & Chr(34) & "%windir%\system32\diskpart.exe" & Chr(34)		
	
	'RUN EXE WITH 30 SEC TIMEOUT
	If (GetExeOutput(strExe & " " & strExeArguments, strStd, 30, DidTimeout)) Then
		strTop = "Volume ###  Ltr  Label        Fs     Type        Size     Status     Info"
		strBottom = ""
	
		'TABLE TO ARRAY
		Call TableToArray(strStd, strTop, strBottom, arrTable, RowCount, True)
	End If	
	
	'GET VOLUMES AS LOGICAL DISKS
	Set colVols = objWMI.ExecQuery("Select * from Win32_LogicalDisk")	
	ReDim VolPairs(5 - 1, colVols.Count - 1)	
	
	'EACH VOLUME
	x = 0
	For Each objVol In colVols 
		'ASSIGN PROPS
		VolPairs(PROP_VOLNAME, x) = PROPNAME_VOLNAME & "|" & objVol.DeviceID
		VolPairs(PROP_VOLTYPE, x) = PROPNAME_VOLTYPE & "|" & objVol.DriveType
		VolPairs(PROP_VOLFS, x) = PROPNAME_VOLFS & "|" & objVol.FileSystem
		VolPairs(PROP_VOLLABEL, x) = PROPNAME_VOLLABEL & "|" & objVol.VolumeName
		VolPairs(PROP_VOLRAID, x) = PROPNAME_VOLRAID & "|"	'ONLY NAME
			
		'CHECK VOLUME IS MIRROR OR RAID5
		strRaid = "-1"
		For y = 0 To RowCount - 1
			'VOLUME MATCH
			If (InStr(1, arrTable(0, y), "Volume", 1) > 0) And (StrComp(objVol.DeviceID, arrTable(1, y) & ":", 1) = 0) Then
				'RAID1 
				If (StrComp(arrTable(4, y), "MIRROR", 1) = 0) Then strRaid = "1"
				'RAID5
				ElseIf (StrComp(arrTable(4, y), "RAID-5", 1) = 0) Then strRaid = "5"			
				'STOP SEARCH
				Exit For				
			End If			 	
		Next		

		'SUPPORTED RAID				
		VolPairs(PROP_VOLRAID, x) = VolPairs(PROP_VOLRAID, x) & strRaid
		
		'INC
		x = x + 1
	Next
	
	'MAKE JSON
	strResult = MakeJSON(VolPairs, colVols.Count)	
	
'GET DISKS
ElseIf (StrComp(strOption, OPT_DISKS, 1) = 0) Then

	'DEFINE JSON PAIRS
	Dim DiskPairs()	'DSKNAME, DSKNO, DSKVOLS, DSKLABEL, DSKSMART
	
	'GET DISKS AS PHYSICAL DISKS
	Set colDisks = objWMI.ExecQuery("Select * from Win32_DiskDrive")	
	ReDim DiskPairs(5 - 1, colDisks.Count - 1)	
	
	'GET PHYSICAL DISK PERFCOUNTERS
	Set colPdpcs = objWMI.ExecQuery("Select * from Win32_PerfRawData_PerfDisk_PhysicalDisk")	
	
	'EACH DISK
	x = 0
	For Each objDisk In colDisks
		'ASSIGN PROPS
		DiskPairs(PROP_DSKNAME, x) = PROPNAME_DSKNAME & "|" & objDisk.DeviceID
		DiskPairs(PROP_DSKNO, x) = PROPNAME_DSKNO & "|" & Right(objDisk.DeviceID, 1)
	   	DiskPairs(PROP_DSKVOLS, x) = PROPNAME_DSKVOLS & "|"		' ONLY NAME
		DiskPairs(PROP_DSKLABEL, x) = PROPNAME_DSKLABEL & "|" & objDisk.Caption
		DiskPairs(PROP_DSKSMART, x) = PROPNAME_DSKSMART & "|" 	' ONLY NAME
		
		'GET PARTITIONS FOR DISK
	    strDeviceID = Replace(objDisk.DeviceID, "\", "\\")
	    Set colPartitions = objWMI.ExecQuery("Associators of {Win32_DiskDrive.DeviceID=" & Chr(34) & strDeviceID & Chr(34) & "} where AssocClass = Win32_DiskDriveToDiskPartition")
	 
    	'EACH PERFCOUNTER
    	For Each objPdpc In colPdpcs 	 
		 	'EACH PARTITION
		 	bPerfMatch = True
		 	y = 0
		    For Each objPartition In colPartitions
		        'GET VOLUMES FOR PARTITION
		        Set colLogicalDisks = objWMI.ExecQuery("Associators of {Win32_DiskPartition.DeviceID=" & Chr(34) & objPartition.DeviceID & Chr(34) & "} where AssocClass = Win32_LogicalDiskToPartition")	        
		        
				'EACH VOLUME AS LOGICALDISK	 			
		        For Each objLogicalDisk In colLogicalDisks	        					
		        	'VOLUME DOES NOT MATCH PERFCOUNTER
		        	If (InStr(1, objPdpc.Name, objLogicalDisk.DeviceID, 1) = 0) Then 
		        		bPerfMatch = False
		        		'STOP SEARCH
		        		Exit For
		        	End If
		        Next
		        
	        	'INC
	        	y = y + 1
		    Next
		    
		    'PERFCOUNTER MATCHES
		    If (bPerfMatch) Then 
		    	'EXTRACT VOLUMES IN CORRECT ORDER
		    	strVolumes = ""
		    	strSplit = Split(objPdpc.Name, " ")
		    	For z = 1 To UBound(strSplit)
		    		'ADD SPACE
		    		If (Len(strVolumes) > 0) Then strVolumes = strVolumes & " "
		    		strVolumes = strVolumes & strSplit(z)
		    	Next
		    	
		    	'ASSIGN PROP
		    	DiskPairs(PROP_DSKVOLS, x) = DiskPairs(PROP_DSKVOLS, x) & strVolumes
		    End If
		Next
	    	    
		'USE SMARTCTL
		strExe = Chr(34) & strCurPath & "\" & "smartctl.exe" & Chr(34)
		strExeArguments = "/dev/pd" & Right(objDisk.DeviceID, 1) & " -H"	
	
		'RUN EXE WITH 3 SEC TIMEOUT
		If (GetExeOutput(strExe & " " & strExeArguments, strStd, 3, DidTimeout)) Then
			'POOR-MAN-REGEX
			strSplit = Split(strStd, "SMART overall-health self-assessment test result: ")
			
			'SUPPORTS SMART
			If (UBound(strSplit) > 0) Then 
				DiskPairs(PROP_DSKSMART, x) = DiskPairs(PROP_DSKSMART, x) & "1"
			Else
				DiskPairs(PROP_DSKSMART, x) = DiskPairs(PROP_DSKSMART, x) & "0"
			End If
		End If	    	
		
		'INC
		x = x + 1
	Next
	
	'MAKE JSON
	strResult = MakeJSON(DiskPairs, colDisks.Count)	
	
'GET SERVICES
ElseIf (StrComp(strOption, OPT_SERVICES, 1) = 0) Then
	
	'DEFINE JSON PAIRS
	Dim SvcPairs()	'SVCNAME, SVCSTARTMODE, SVCDISPNAME
	
	'GET SERVICES
	Set colSvcs = objWMI.ExecQuery("Select * from Win32_Service")	
	ReDim SvcPairs(3 - 1, colSvcs.Count - 1)	
	
	'SET EXCEPTIONS
	Dim Exceptions(6)
	Exceptions(0) = "^Sysmonlog$" 			'PERFORMANCE LOGS AND ALERTS
	Exceptions(1) = "^WLMS$" 				'WINDOWS LICENSING MONITORING SERVICE
	Exceptions(2) = "^sppsvc$" 				'SOFTWARE PROTECTION
	Exceptions(3) = "^clr_optimization.*"	'NET FRAMEWORK * OPTIMIZATION
	Exceptions(4) = "^SQLAgent$"			'SQL AGENT
	Exceptions(5) = "^TrustedInstaller$"	'WINDOWS MODULE INSTALLER
	Exceptions(6) = "^ShellHWDetection$"	'SHELL HARDWARE DETECTION
	
	'REGEX
	Set Regex = New RegExp
	Regex.IgnoreCase = True			
	
	'EACH VOLUME
	x = 0
	c = 0
	For Each objSvc In colSvcs 
		'EXCEPTIONS
		bExcepted = False
		For q = 0 To UBound(Exceptions)
			'MATCH EXCEPTED SERVICE
			Regex.Pattern = Exceptions(q)
			If (Regex.Test(objSvc.Name)) Then
				bExcepted = True
				Exit For
			End If
		Next
	
		'SERVICE EXCEPTED
		If (Not bExcepted) Then
			'DISPLAY NAME    
			strDisplay = objSvc.DisplayName
			
			'APPLICATION EXPERIENCE/APPLICATION EXPERIENCE LOOKUP SERVICE
			If (StrComp(objSvc.Name, "AeLookupSvc", 1) = 0) Then strDisplay = "Application Experience Lookup Service"
			'EVENT LOG/WINDOWS EVENT LOG
			If (StrComp(objSvc.Name, "eventlog", 1) = 0) Then strDisplay = "Event Log/Windows Event Log"			
			'HUMAN INTERFACE DEVICE ACCESS/HID INPUT SERVICE
			If (StrComp(objSvc.Name, "HidServ", 1) = 0) Then strDisplay = "HID Input Service/Human Interface Device Access"			
			'NET LOGON/NETLOGON
			If (StrComp(objSvc.Name, "Netlogon", 1) = 0) Then strDisplay = "Net Logon"			
			'IPSEC POLICY AGENT/IPSEC SERVICES
			If (StrComp(objSvc.Name, "PolicyAgent", 1) = 0) Then strDisplay = "IPsec Policy Agent/IPSEC Services"
			'SYSTEM EVENT NOTIFICATION SERVICE/SYSTEM EVENT NOTIFICATION
			If (StrComp(objSvc.Name, "SENS", 1) = 0) Then strDisplay = "System Event Notification Service"
			'INTERNET CONNECTION SHARING/WINDOWS FIREWALL
			If (StrComp(objSvc.Name, "SharedAccess", 1) = 0) Then strDisplay = "Windows Firewall/Internet Connection Sharing (ICS)"			
			'REMOTE DESKTOP SERVICES/TERMINAL SERVICES
			If (StrComp(objSvc.Name, "TermService", 1) = 0) Then strDisplay = "Remote Desktop Services/Terminal Services"
			'VIRTUAL DISK/VIRTUAL DISK SERVICE
			If (StrComp(objSvc.Name, "vds", 1) = 0) Then strDisplay = "Virtual Disk Service"
			'AUTOMATIC UPDATES/WINDOWS UPDATES
			If (StrComp(objSvc.Name, "wuauserv", 1) = 0) Then strDisplay = "Automatic Updates/Windows Updates"			
		
			'ASSIGN PROPS
			SvcPairs(PROP_SVCNAME, c) = PROPNAME_SVCNAME & "|" & objSvc.Name
			SvcPairs(PROP_SVCSTARTMODE, c) = PROPNAME_SVCSTARTMODE & "|" & objSvc.StartMode
			SvcPairs(PROP_SVCDISPNAME, c) = PROPNAME_SVCDISPNAME & "|" & strDisplay
			'INC
			c = c + 1
		End If
		'INC
		x = x + 1
	Next
		
	'MAKE JSON
	strResult = MakeJSON(SvcPairs, c)	
	
'GET CPUS
ElseIf (StrComp(strOption, OPT_CPUS, 1) = 0) Then	

	'DEFINE JSON PAIRS
	Dim CpuPairs()	'CPUNO

	'GET CPUS
	Set colCpus = objWMI.ExecQuery("Select * from Win32_PerfRawData_PerfOS_Processor")
	
	'ASSUME _TOTAL
	ReDim CpuPairs(1 - 1, colCpus.Count - 2)	
	'EACH CPU
	For x = 0 To colCpus.Count - 2
		CpuPairs(PROP_CPUNO, x) = PROPNAME_CPUNO & "|" & x
	Next
	
	'MAKE JSON
	strResult = MakeJSON(CpuPairs, colCpus.Count - 1)
	
'GET NICS
ElseIf (StrComp(strOption, OPT_NICS, 1) = 0) Then	

	'DEFINE JSON PAIRS
	Dim NicPairs()	'NICNAME, NICDEV, NICDEVNUM, NICPERF, NICMAC, NICSTATE, NICADDR

	'GET NICS
	Set colNics = objWMI.ExecQuery("Select * from Win32_NetworkAdapter")	
	ReDim NicPairs(7 - 1, colNics.Count - 1)
	
	'EACH NIC
	x = 0
	c = 0
	For Each objNic In colNics
		'NIC HAS ASSOCIATED NETWORK CONNECTION
		If (Len(objNic.NetConnectionId) > 0) Then
			'ASSIGN PROPS
			colNicIndex = Replace(objNic.Index, "\", "\\")
			Set colNicConfig = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE Index = '" & colNicIndex & "'") 
	
			For Each objNicConfig In colNicConfig
				NicPairs(PROP_NICNAME, c) = PROPNAME_NICNAME & "|" & objNic.NetConnectionId
				NicPairs(PROP_NICDEV, c) = PROPNAME_NICDEV & "|" & objNic.Description
				NicPairs(PROP_NICDEVNUM, c) = PROPNAME_NICDEVNUM & "|"	'ONLY NAME
				NicPairs(PROP_NICPERF, c) = PROPNAME_NICPERF & "|"	'ONLY NAME
				NicPairs(PROP_NICMAC, c) = PROPNAME_NICMAC & "|" & objNic.MACAddress
				NicPairs(PROP_NICSTATE, c) = PROPNAME_NICSTATE & "|" & objNic.NetConnectionStatus	
				If isNull(objNicConfig.IPAddress) Then
					NicPairs(PROP_NICADDR, c) = PROPNAME_NICADDR & "|" & ""
				Else
					NicPairs(PROP_NICADDR, c) = PROPNAME_NICADDR & "|" & join(objNicConfig.IPAddress, ",")
				End If
			Next
	
	        'GET PNP DEVICE FOR NIC
	        strPNPDeviceID = Replace(objNic.PNPDeviceID, "\", "\\")
	        Set colPnpEntities = objWMI.ExecQuery("Select * from Win32_PNPEntity where DeviceID = '" & strPNPDeviceID & "'")
	        
	        'EACH DEVICE NUMBERED NAME
	        For Each objPnp In colPnpEntities
	        	NicPairs(PROP_NICDEVNUM, c) = NicPairs(PROP_NICDEVNUM, c) & objPnp.Caption
	        	
	        	'FORMAT PERF
	        	strPerf = Replace(Replace(objPnp.Caption, "(", "["), ")", "]")
	        	strPerf = Replace(Replace(Replace(strPerf, "#", "_"), "\", "_"), "/", "_")
	        	NicPairs(PROP_NICPERF, c) = NicPairs(PROP_NICPERF, c) & strPerf
	        Next
	        			
			'INC 
			c = c + 1
		End If
		
		'INC
		x = x + 1
	Next
	
	'MAKE JSON
	strResult = MakeJSON(NicPairs, c)
	
'GET QUOTAS
ElseIf (StrComp(strOption, OPT_QUOTAS, 1) = 0) Then		

	'FSRM.FSRMQUOTAMANAGER IS SUPPORTED IN 2008, USE DIRQUOTA TO SUPPORT 2003s
	
	'CHECK NATIVE BITNESS
	Call CheckNativeBitness		
	
	'DEFINE JSON PAIRS
	Dim QuotaPairs()	'QUPATH, QUSTATUS, QULIMIT, QUUSED, QUFREE	
	
	'TABLEARR
	Dim arrQTable()
	
	'USE DIRQUOTA
	strExe = Chr(34) & "%windir%\system32\dirquota.exe" & Chr(34)
	strExeArguments = "quota list"	

	'RUN EXE WITH 3 SEC TIMEOUT
	If (GetExeOutput(strExe & " " & strExeArguments, strStd, 3, DidTimeout)) Then
		strTop = "Quota Path:"
		Dim arrQLines(3)
		arrQLines(0) = "Quota Status:"
		arrQLines(1) = "Limit:"
		arrQLines(2) = "Used:"
		arrQLines(3) = "Available:"
		
		'LIST TO ARRAY
		If (ListToArray(strStd, strTop, arrQLines, arrQTable, RowCount)) Then
				
			'GET QUOTA
			ReDim QuotaPairs(2 - 1, RowCount - 1)
			
			'EACH ROW (QUOTA)
			For x = 0 To RowCount - 1
				'ASSIGN PROPS
				QuotaPairs(PROP_QUPATH, x) = PROPNAME_QUPATH & "|" & arrQTable(0, x)
				QuotaPairs(PROP_QUSTATUS, x) = PROPNAME_QUSTATUS & "|" & arrQTable(1, x)
			Next			
		End If		
	End If

	'MAKE JSON
	strResult = MakeJSON(QuotaPairs, RowCount)
	
'GET PROCESSES
ElseIf (StrComp(strOption, OPT_PROCESSES, 1) = 0) Then		
	
	'DEFINE JSON PAIRS
	Dim ProcPairs()	'PRNAME, PRSIZE (10, 25, 50, 100, 250, 500, 1000, Higher)
	
	'PROCS DICTIONARY
	Set dicProcs = CreateObject("Scripting.Dictionary")
	Dim arrProcs()
	
	'GET PROCESSES
	Set colProcs = objWMI.ExecQuery("Select * from Win32_PerfFormattedData_PerfProc_Process")
	
	'ASSUME _TOTAL
	ReDim ProcPairs(1 - 1, colProcs.Count - 2)	
	'EACH PROCESS
	For Each objProc In colProcs
		'NOT _TOTAL
		If (StrComp(objProc.Name, "_Total", 1) <> 0) Then
			'NAME
			strExe = objProc.Name
			'POOR-MAN-REGEX
			strSplit = Split(strExe, "#")
			'KEEP THE BASE NAME, NOT PERFCOUNTER NUMBERING
			If (UBound(strSplit) > 0) Then strExe = strSplit(0)
			'ADD EXE
			strExe = strExe & ".exe"
			
			'DICTIONARY EMPTY
			If (Not dicProcs.Exists(strExe)) Then
				Call dicProcs.Add(strExe, objProc.PrivateBytes)
			Else
				'SUM UP MEMORY
				dicProcs(strExe) = CDbl(dicProcs(strExe)) + CDbl(objProc.PrivateBytes)
			End If
		End If		
	Next
		
	'MAKE ARRAY
	Call DictionaryToArray(dicProcs, arrProcs, RowCount)
	'SORT BY SIZE, HIGHEST TOP
	Call SortArray(arrProcs, 1, RowCount)
		
	'GET PROCESS
	ReDim ProcPairs(2 - 1, RowCount - 1)					
		
	'EACH ROW (PROCESS)
	For x = 0 To RowCount - 1
		'ASSIGN PROPS
		ProcPairs(PROP_PRNAME, x) = PROPNAME_PRNAME & "|" & arrProcs(0, x)
		
		'MIN SIZE (<10 MB)
		If (CDbl(arrProcs(1, x)) <= 10 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "10"		
		'MIN SIZE (<25 MB)
		ElseIf (CDbl(arrProcs(1, x)) <= 25 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "25"
		'AVG SIZE (<50MB)
		ElseIf (CDbl(arrProcs(1, x)) <= 50 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "50"
		'AVG SIZE (<100MB)
		ElseIf (CDbl(arrProcs(1, x)) <= 100 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "100"
		'AVG SIZE (<250MB)
		ElseIf (CDbl(arrProcs(1, x)) <= 250 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "250"
		'AVG SIZE (<500MB)
		ElseIf (CDbl(arrProcs(1, x)) <= 500 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "500"
		'AVG SIZE (<1000MB)
		ElseIf (CDbl(arrProcs(1, x)) <= 500 * 1024 * 1024) Then
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "1000"
		'AVG SIZE (>1000MB)
		Else
			ProcPairs(PROP_PRSIZE, x) = PROPNAME_PRSIZE & "|" & "Higher"
		End If
	Next	
	
	'MAKE JSON
	strResult = MakeJSON(ProcPairs, RowCount)	
	
End If




'ZABBIX RESULT
Call WScript.Echo(strResult)