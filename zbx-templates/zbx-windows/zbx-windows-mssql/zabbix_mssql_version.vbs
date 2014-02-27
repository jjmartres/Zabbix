'-------------------------------------------------------------------------------
' OCSINVENTORY-NG
' Web : http://www.ocsinventory-ng.org
'
' Liste les bases de donn�es SQL Server du poste
'  4 donn�es sont remont�es :
'  - strSQLName :     Nom long du produit SQL Server
'                     Par exple : "Microsoft SQL Server 2008 R2"
'  - strServiceName : Nom de l'instance
'                     Par exple : "MSSQLSERVER"
'  - strEdition :     Edition.
'                     Par exple : "Enterprise Edition (64-bit)"
'  - strVersion :     Version "chiffr�e".
'                     Par exple : "8.00.194"
'
' Auteur  : Sylvie Grimonpont
' Date    : 21-10-2011
' Version : 1.0.0
'
' This code is open source and may be copied and modified as long as the source
' code is always made freely available.
' Please refer to the General Public Licence http://www.gnu.org/ or Licence.txt
'-------------------------------------------------------------------------------

On Error Resume Next

'D�claration des constantes
Const DblQuote  = """"
Const ForReading = 1
Const HKEY_LOCAL_MACHINE   = &H80000002
Const strMSSQLServerRegKey = "SOFTWARE\Microsoft\MSSQLServer\MSSQLServer\Parameters"
Const REG_SZ = 1

Set Arg = WScript.Arguments
if WScript.Arguments.Count = 0 then
    WScript.Echo "Missing parameters"
end if

' Sp�cificit�s SQL 2000
   ' RegExp pour r�cup�ration de l'�dition dans un fichier ERRORLOG
   Set regexpEdition = New RegExp
   regexpEdition.IgnoreCase = True
   regexpEdition.Global = True
   regexpEdition.Pattern = "^.*dition"

   ' RegExp pour r�cup�ration de la version dans un fichier ERRORLOG
   Set regexpVersion = New RegExp
   regexpVersion.IgnoreCase = True
   regexpVersion.Global = True
   regexpVersion.Pattern = "-[^-(]+(\(|$)"


' Initialisation des variables
strSourceServer = "."

' Recherche d'un service ayant sqlservr.exe dans son path. Si ce service n'existe pas, aucune base sql ne tourne.
Set objWMIcimv2  = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strSourceServer & "\root\cimv2")
If Err = 0 Then

   Set colServices = objWMIcimv2.ExecQuery("Select Name , PathName from Win32_Service Where PathName Like '%sqlservr.exe%'")
   If Err = 0 Then
      If colServices.count > 0 Then
         If Err = 0 Then
            'Wscript.Echo "SQL Server trouv� !"
            For Each objService in colServices
               ' ServiceName
               strServiceName = objService.Name
               If InStr(strServiceName,"$") > 0 Then
                  strServiceName =  Mid(strServiceName, InStr(strServiceName,"$") + 1)
               End If

               ' PathName, Drive et Path
               strPathName = objService.PathName
               If Left(strPathName, 1) = DblQuote Then strPathName= Mid(strPathName, 2)
               strDrive = Mid(strPathName, 1, 2)
               strPath  = Mid(strPathName, 3, InStr(1, strPathName, "sqlservr.exe") - 3)

               ' Recherche la version du fichier sqlservr.exe
               strCIMDatafile = "Select FileName,Extension,Version from CIM_Datafile" _
                              & " Where Drive = '" & strDrive & "'" _
                              & " and Path = '" & Replace( strPath ,"\","\\") & "'" _
                              & " and FileName = 'sqlservr' and Extension = 'exe'"

               ' Si on a eu une erreur entre temps, on efface
               Err.Clear

               Set colSQLFile = objWMIcimv2.ExecQuery ( strCIMDatafile )
               If Err = 0 Then
                  For Each objSQLFile in colSQLFile
                     If Not IsNull(objSQLFile.Version) Then
                        arrSQLFileVersion=Split(objSQLFile.Version,".")
                        strSQLFileVersion=Cint(arrSQLFileVersion(1))
                     Else
                        strSQLFileVersion=0
                     End If

                     ' Initialisation
                     strVersion =""
                     strEdition =""
                     strWMIsql = ""
                     strError = ""

                     ' Positionne la classe WMI SqlServer en fonction de la version du fichier sqlservr.exe
                     If strSQLFileVersion = 90 Then strWMIsql = "ComputerManagement"
                     If strSQLFileVersion = 100 Then strWMIsql = "ComputerManagement10"
                     If strSQLFileVersion = 110 Then strWMIsql = "ComputerManagement11"

                     ' Recherche la version et l'�dition de la base SQL via la classe WMI SqlServer si disponible
                     If (strWMIsql <> "") Then
                        ' Si on a eu une erreur entre temps, on efface
                        Err.Clear
                        Set objWMIsql = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strSourceServer & "\root\Microsoft\SqlServer\" & strWMIsql)
                        If Err = 0 Then
                           For Each prop in objWMIsql.ExecQuery("select * from SqlServiceAdvancedProperty Where SQLServiceType = 1 And ServiceName='" & objService.Name & "'")
                              If Err = 0 Then
                                 If (prop.PropertyName="VERSION") Then strVersion = prop.PropertyStrValue
                                 If (prop.PropertyName="SKUNAME") Then strEdition = prop.PropertyStrValue
                              Else
                                 WriteError()
                              End If
                           Next
                           If Err <> 0 Then WriteError()
                        Else
                           WriteError()
                        End If
                     End If

                     ' Si on n'a pas pu determiner la version et l'�dition � partir de la classe WMI (cas SQL Server 2000), on essaie de la d�terminer � partir du fichier ERRORLOG (si en local)
                     If (((strWMIsql= "") Or (strVersion = "") Or (strEdition = "")) And (strSourceServer = ".")) Then
                        ' On ne trappe plus les erreurs...
                        On Error Goto 0
                        ' Recherche du chemin du fichier ERRORLOG dans la base de registre
                        Set objRegistry = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strSourceServer & "\root\default:StdRegProv")
                        If objRegistry.EnumKey (HKEY_LOCAL_MACHINE, strMSSQLServerRegKey, arrSubKeys) = 0 Then
                           strErrorlogPath = ""
                           objRegistry.EnumValues HKEY_LOCAL_MACHINE, strMSSQLServerRegKey, arrValueNames, arrValueTypes
                           For I=0 To UBound(arrValueNames)
                               If arrValueTypes(I) = REG_SZ Then
                                  objRegistry.GetStringValue HKEY_LOCAL_MACHINE,strMSSQLServerRegKey,arrValueNames(I),strValue
                                  ' Dans HKLMSOFTWARE\Microsoft\MSSQLServer\MSSQLServer\Parameters, le param�tre qui commence par "-e" d�finie le path de ERRORLOG
                                  If Left(strValue,2) = "-e" Then
                                     strErrorlogPath = Mid(strValue,3)
                                  End If
                               End If
                           Next

                           ' Si on a trouv� le chemin du fichier ERRORLOG dans la base de registre, on essaie de lire le fichier en question
                           If strErrorlogPath <> "" Then
                              ' Teste l'existence du fichier
                              Set objFSO = CreateObject("Scripting.FileSystemObject")
                              If objFSO.FileExists(strErrorlogPath) Then
                                 ' Teste la taille du fichier
                                 Set objErrorlogFile = objFSO.GetFile(strErrorlogPath)
                                 If objErrorlogFile.Size > 0 Then
                                    ' Lit le fichier
                                    ReadErrorLog(strErrorlogPath)
                                 Else
                                    ' On essaie avec le fichier ERRORLOG.1
                                    Set objErrorlogFile = objFSO.GetFile(strErrorlogPath & ".1")
                                    If objErrorlogFile.Size > 0 Then
                                       ReadErrorLog(strErrorlogPath & ".1")
                                    Else
                                       strError = "Le fichier " & strErrorlogPath & " est vide"
                                    End If
                                 End If
                              Else
                                 strError = "Le fichier " & strErrorlogPath & " n'existe pas"
                              End If
                           Else
                              strError = "Information sur fichier ERRORLOG non trouv�e en base de registre"
                           End If
                        Else
                           strError = "Information sur fichier ERRORLOG non trouv�e en base de registre"
                        End If
                     End If
                     ' R�cup�ration du nom SQL Server
                     If Left(strVersion,3) = "6.5" Then
                        strSQLName = "Microsoft SQL Server 6.5"
                     ElseIf Left(strVersion,1) = "7" Then
                        strSQLName = "Microsoft SQL Server 7.0"
                     ElseIf Left(strVersion,1) = "8" Then
                        strSQLName = "Microsoft SQL Server 2000"
                     ElseIf Left(strVersion,1) = "9" Then
                        strSQLName = "Microsoft SQL Server 2005"
                     ElseIf Left(strVersion,4) = "10.0" Then
                        strSQLName = "Microsoft SQL Server 2008"
                     ElseIf Left(strVersion,4) = "10.5" Then
                        strSQLName = "Microsoft SQL Server 2008 R2"
          ElseIf Left(strVersion,4) = "11.0" Then
                        strSQLName = "Microsoft SQL Server 2012"
                     Else
                        strSQLName = "Microsoft SQL Server"
                     End if

                     ' Ecrit les donn�es de sortie

                     ' Les donn�es disponibles sont :
                     ' - strSQLName :     Nom long du produit SQL Server
                     ' - strServiceName : Nom de l'instance
                     ' - strEdition :     Edition. Par exple : Enterprise Edition (64-bit) / Express Edition
                     ' - strVersion :     Version "chiffr�e". Par exemple : 8.00.194 / 10.50.1600.1
           Select Case Arg(0)
           Case "NAME"
            Wscript.Echo strSQLName
           Case "EDITION"
            Wscript.Echo strEdition
           Case "VERSION"
            Wscript.Echo strVersion
           Case "FULL"
            Wscript.Echo strSQLName & ", " & strEdition
           Case "DBMAX"
            If InStr(strVersion, "2005") > 0 OR InStr(strVersion, "2000") AND InStr(strValue, "Express") > 0 Then
              Wscript.Echo "4294967296"          '4GB
            ElseIf InStr(strVersion, "2008") > 0 OR InStr(strVersion, "2012") AND InStr(strValue, "Express") > 0 Then
              Wscript.Echo "10737418240"          '10GB
            Else
              Wscript.Echo "589971551185534976"      '524PB
            End If
           Case Else
            Wscript.Echo "Wrong parameter !"
           End Select
                  Next
               Else
                  WriteError()
               End If
            Next
         Else
            WriteError()
         End If
      Else
         On Error Goto 0
         'Wscript.Echo "Aucun SQL Server trouv� !"
      End if
   Else
      WriteError()
   End If
Else
   WriteError()
End If

On Error Goto 0

WScript.Quit

Sub WriteError()
   strError = "Erreur " & Err.Number & " - " & Err.Description

   '         ' On �crit l'erreur dans le fichier

   Err.Clear
End Sub

Function MultilineTrim (Byval TextData)
    Dim textRegExp
    Set textRegExp = new regexp
    textRegExp.Pattern = "\s{0,}(\S{1}[\s,\S]*\S{1})\s{0,}"
    textRegExp.Global = False
    textRegExp.IgnoreCase = True
    textRegExp.Multiline = True

    If textRegExp.Test (TextData) Then
        MultilineTrim = textRegExp.Replace (TextData, "$1")
    Else
        MultilineTrim = ""
    End If
End Function

Sub ReadErrorLog (strFilePath)
   ' Lit le fichier
   Set objTextFile =objFSO.OpenTextFile(strFilePath, ForReading, False)
   For i = 1 To 4
      strErrorlogText = objTextFile.Readline

      ' La version se trouve sur la premi�re ligne
      If i = 1 Then
         Set versions = regexpVersion.Execute(strErrorlogText)
         For Each version In versions
            strVersion = version
            If Left(strVersion,1)  = "-" Then strVersion = Mid(strVersion,2)
            If Right(strVersion,1) = "(" Then strVersion = Left(strVersion,Len(strVersion)-1)
            strVersion = MultilineTrim(strVersion)
         Next
         If strVersion="" Then strVersion = "Errolog"
      End If

      ' L'�dition se trouve sur la quatri�me ligne
      If i = 4 Then
         strEdition = strErrorlogText
         Set editions = regexpEdition.Execute(strErrorlogText)
         For Each edition In editions
            strEdition = edition
            strEdition = MultilineTrim(strEdition)
         Next
         If strEdition="" Then strEdition = "Errolog"
      End If

   Next
   objTextFile.Close
End Sub
