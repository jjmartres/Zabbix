'2012.07.03
'added TB to getquotabytes

'2012.06.29
'fixed null string handling in addsaveddata

'2012.06.14



Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 
strCurPath = objFSO.GetParentFolderName(WScript.ScriptFullName)
strSavedFile = objFSO.GetBaseName(WScript.ScriptFullName) & ".saved"



'FILE OPERATIONS
FOR_READ = 1
FOR_WRITE = 2
FOR_APPEND = 8


'OPTIONS
OPT_LIMIT	= "LIMIT"
OPT_USED    = "USED"
OPT_FREE	= "FREE"


'SAVED IDENTIFIERS 
SAVID_QUPATH    = 0
SAVID_ATTRIBUTE  = 1


'SAVED DATA
SAVDATA_TIMEDATE = 0
SAVDATA_VALUE    = 1



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


'OPEN FILE READ
Function OpenFileRead(strDataFile, ByRef strData)
On Error Resume Next

	'RESULT
	OpenFileRead = False
	
	Dim RetryCount
	RetryCount = 0	

	'FILE EXISTS
	If (objFSO.FileExists(strDataFile)) Then
		Set objFile = objFSO.GetFile(strDataFile)
		
		'TRY LOCK FILE FOR 5 SEC
		Do While (OpenFileRead = False) And (RetryCount < 100)
			'CLEAR ERR
			Err.Clear
			'OPEN FILE
			Set objFileLock = objFSO.OpenTextFile(strDataFile, FOR_APPEND, True)
			'ERR CHECK
			If (Err.Number > 0) Then
				RetryCount = RetryCount + 1
				Wscript.Sleep(50)
				'#DEBUG
'					Wscript.echo "Retry no: " & RetryCount
'					Wscript.echo "Error: " & Err.Description
			Else
				Set objFile = objFSO.OpenTextFile(strDataFile, FOR_READ, True)
				strData = objFile.ReadAll
				objFile.Close
				objFileLock.Close					
				
				'RESULT
				OpenFileRead = True										
			End If
		Loop
	Else
		'FILE DOES NOT EXIST, NOT AN ERR
		OpenFileRead = True
	End If
End Function


'OPEN FILE WRITE
Function OpenFileWrite(strDataFile, strData)
On Error Resume Next
	
	'RESULT
	OpenFileWrite = False
	
	Dim RetryCount
	RetryCount = 0
	
	'TRY OPEN FILE WRITE FOR 5 SEC
	Do While (OpenFileWrite = False) And (RetryCount < 100)
		'CLEAR ERR
		Err.Clear
		'OPEN FILE
		Set objFile = objFSO.OpenTextFile(strDataFile, FOR_WRITE, True)
		'ERR CHECK
		If (Err.Number > 0) Then
			RetryCount = RetryCount + 1
			Wscript.Sleep(50)
			'#DEBUG
'			Wscript.echo "Retry no: " & RetryCount
'			Wscript.echo "Error: " & Err.Description
		Else
			objFile.Write(strData)
			objFile.Close
			
			'RESULT
			OpenFileWrite = True
		End If
	Loop
End Function


'ADD SAVED DATA
Function AddSavedData(ByRef strData, Identifiers, Datas)
	'REPLACE
	For x = 0 To UBound(Identifiers)
		If (IsNull(Identifiers(x))) Then Identifiers(x) = ""
		Identifiers(x) = Replace(Identifiers(x), "|", "`")			
	Next
	'REPLACE
	For x = 0 To UBound(Datas)
		If (IsNull(Datas(x))) Then Datas(x) = ""
		Datas(x) = Replace(Datas(x), "|", "`")
	Next

	'FOUND
	bFound = False
	splitData = Split(strData, vbCrLf)
		
	'EACH LINE
	For x = 0 To UBound(splitData)
		splitLine = Split(splitData(x), "|")
		
		'LINE HAS IDENTIFIER + DATAS MEMBERS
		If (UBound(splitLine) = UBound(Identifiers) + UBound(Datas) + 1) Then		
			'FOUND
			bFound = True
		
			'ALL IDENTIFIERS IN LINE MATCH
			For y = 0 To UBound(Identifiers)
				If (StrComp(Identifiers(y), splitLine(y), 1) <> 0) Then
					'FOUND
					bFound = False
					'EXIT LINE SEARCH
					Exit For
				End If
			Next
			
			'FOUND
			If (bFound = True) Then
				'UPDATE SPLITLINE
				splitData(x) = Join(Identifiers, "|") & "|" & Join(Datas, "|")
				'EXIT ALL LINES SEARCH
				Exit For
			End If
		End If
	Next
	
	strData = Join(splitData, vbCrLf)
	
	'NOT FOUND, ADD NEW LINE
	If (bFound = False) Then
		strLine = Join(Identifiers, "|") & "|" & Join(Datas, "|")
		If (Len(strData)> 0) Then
			strData = strData & vbCrLf & strLine
		Else
			strData = strLine
		End If
	End If	
End Function


'FIND SAVED Data
Function FindSavedData(strData, Identifiers, ByRef Datas)
	'REPLACE
	For x = 0 To UBound(Identifiers)
		Identifiers(x) = Replace(Identifiers(x), "|", "`")
	Next

	'FOUND
	bFound = False
	splitData = Split(strData, vbCrLf)
	
	'EACH LINE
	For x = 0 To UBound(splitData)
		splitLine = Split(splitData(x), "|")
		
		'LINE HAS IDENTIFIER + DATAS MEMBERS
		If (UBound(splitLine) >= UBound(Identifiers) + UBound(Datas) + 1) Then		
			'FOUND
			bFound = True
		
			'ALL IDENTIFIERS IN LINE MATCH
			For y = 0 To UBound(Identifiers)
				If (StrComp(Identifiers(y), splitLine(y), 1) <> 0) Then
					'FOUND
					bFound = False
					'EXIT LINE SEARCH
					Exit For
				End If
			Next
			
			'FOUND
			If (bFound = True) Then
				'RETURN DATAS FOR FOUND LINE
				For y = UBound(Identifiers) + 1 To UBound(Identifiers) + 1 + UBound(Datas)
					Datas(y - UBound(Identifiers) - 1) = Replace(splitLine(y), "`", "|")
				Next
				'EXIT SEARCH
				Exit For				
			End If
		End If
	Next
	
	'RETURN
	FindSavedData = bFound
End Function


'TABLETOSTRING
Function TableToString(arrTable, RowCount)
	str1 = (UBound(arrTable) + 1) & "|" & RowCount
	
	'EACH ROW
	For x = 0 To RowCount - 1
		'EACH COLUMN
		For y = 0 To UBound(arrTable)
			str1 = str1 & "|" & Replace(arrTable(y, x), "|", "`")
		Next
	Next	
	
	'RESULT
	TableToString = str1	
End Function


'STRINGTOTABLE
Function StringToTable(strTable, arrTable, ByRef RowCount)
	strSplit = Split(strTable, "|")
	
	'VALID TABLE
	If (UBound(strSplit) > 1) Then	
		'COLS, ROWS
		ColCount = CInt(strSplit(0))
		RowCount = CInt(strSplit(1))
		
		'SET TABLE
		startx = 2
		ReDim arrTable(ColCount - 1, RowCount - 1)
	
		'EACH ROW
		For x = 0 To RowCount - 1
			'EACH COLUMN
			For y = 0 To UBound(arrTable)
				arrTable(y, x) = Replace(strSplit(startx), "`", "|")
				'INC
				startx = startx + 1
			Next
		Next	
	End If		
End Function


'GETSAVEATTRIBUTES
Function GetSaveAttributes
	'LOAD DATA
	If (OpenFileRead(strCurPath & "\" & strSavedFile, strData)) Then
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
				'SET DATA (PART)
				Dim Identifiers(1)
				Dim Datas(1)
				Identifiers(SAVID_QUPATH) = strQupath
				Datas(SAVDATA_TIMEDATE) = Now					
					
				'EACH ROW (QUOTA)
				For x = 0 To RowCount - 1
					'QUOTA MATCH
					If (StrComp(arrQTable(0, x), strQupath, 1) = 0) Then
						'SET DATA
						Identifiers(SAVID_ATTRIBUTE) = OPT_LIMIT
						Datas(SAVDATA_VALUE) = GetQuotaBytes(arrQTable(2, x))
						'ADD DATA
						Call AddSavedData(strData, Identifiers, Datas)						
						
						'SET DATA
						Identifiers(SAVID_ATTRIBUTE) = OPT_USED
						Datas(SAVDATA_VALUE) = GetQuotaBytes(arrQTable(3, x))
						'ADD DATA
						Call AddSavedData(strData, Identifiers, Datas)	
						
						'SET DATA
						Identifiers(SAVID_ATTRIBUTE) = OPT_FREE
						Datas(SAVDATA_VALUE) = GetQuotaBytes(arrQTable(4, x))
						'ADD DATA
						Call AddSavedData(strData, Identifiers, Datas)																		
					End If
				Next			
	
				'SAVE DATA
				Call OpenFileWrite(strCurPath & "\" & strSavedFile, strData)
			End If
		Else
			'ERROR
			Call WScript.echo("Failed to run exe " & Chr(34) & strExe & " " & strExeArguments & Chr(34) & " or timedout.")
			
			'QUIT
			WScript.Quit	
		End If
	End If
End Function


'GETLOADATTRIBUTE
Function GetLoadAttribute(strVolname, strAttribute)
	'LOAD DATA
	If (OpenFileRead(strCurPath & "\" & strSavedFile, strData)) Then
		'SET IDENTIFIERS
		Dim Identifiers(1)
		Dim Datas(1)
		Identifiers(SAVID_VOLNAME) = strVolname
		Identifiers(SAVID_ATTRIBUTE) = strAttribute
		
		'FIND DATA
		If (FindSavedData(strData, Identifiers, Datas)) Then
			'DATA NOT EXPIRED
			If (DateDiff("h", Datas(SAVDATA_TIMEDATE), Now) < 12) Then		
				'RESULT
				GetLoadAttribute = Datas(SAVDATA_VALUE)
			End If
		End If
	Else
		'ERROR
		Call WScript.echo("Failed to open file " & Chr(34) & strSavedFile & Chr(34) & ".")
		
		'QUIT
		WScript.Quit			
	End If			
End Function


'GET QUOTA BYTES
Function GetQuotaBytes(s)
	'RESULT
	GetQuotaBytes = -1

	'KB POOR-MAN-REGEX
	strSplit = Split(s, "KB")
	'FOUND
	If (UBound(strSplit) > 0) Then GetQuotaBytes = Round(Trim(strSplit(0)) * 1024)
	
	'KB POOR-MAN-REGEX
	strSplit = Split(s, "MB")
	'FOUND
	If (UBound(strSplit) > 0) Then GetQuotaBytes = Round(Trim(strSplit(0)) * 1024	* 1024)

	'KB POOR-MAN-REGEX
	strSplit = Split(s, "GB")
	'FOUND
	If (UBound(strSplit) > 0) Then GetQuotaBytes = Round(Trim(strSplit(0)) * 1024	* 1024 * 1024)
	
	'KB POOR-MAN-REGEX
	strSplit = Split(s, "TB")
	'FOUND
	If (UBound(strSplit) > 0) Then GetQuotaBytes = Round(Trim(strSplit(0)) * 1024	* 1024 * 1024 * 1024)
End Function




'ARGUMENTS
' 0 : OPTION = [LIMIT, USED, FREE]
' 1 : QUPATH

'CHECK ARGUMENTS
Call CheckArguments(2)

'GET ARGUMENTS
strOption = WScript.Arguments(0)
strQupath = WScript.Arguments(1)




'GET LIMIT
If (StrComp(strOption, OPT_LIMIT, 1) = 0) Then

	'CHECK NATIVE BITNESS
	Call CheckNativeBitness
			
	'GET ATTRIBUTES AND SAVE NOW, TO BE JUST LOADED LATER
	Call GetSaveAttributes
	
	'GET LEVEL FROM SAVED FILE
	strResult = GetLoadAttribute(strQupath, strOption)
	
'GET ATTRIBUTES
Else

	'GET ATTRIBUTE FROM SAVED FILE
	strResult = GetLoadAttribute(strQupath, strOption)			

End If




'ZABBIX RESULT
Call WScript.Echo(strResult)