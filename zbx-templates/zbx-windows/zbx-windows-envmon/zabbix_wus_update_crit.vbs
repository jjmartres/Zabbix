Set updateSession = CreateObject("Microsoft.Update.Session") 
Set updateSearcher = updateSession.CreateupdateSearcher()
Set searchResult = updateSearcher.Search("IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'")
WScript.Echo searchResult.Updates.Count 