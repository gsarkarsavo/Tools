param([string]$toDo)

$searchDir = "E:\Web"

if(Test-Path $searchDir)
{
	Write-Host "Initiating ${toDo}..." 
	
	if($toDo -eq "bleed")
	{
		Write-Host "Applying tags to all alive.html and alive.aspx files in ${searchDir}..." 
		cd $searchDir
		Write-Host "Initiating ${toDo}..." 
		Get-ChildItem -Filter "alive.html" -Recurse | Rename-Item -NewName {$_.name -replace '.html','.html_bleeding' }
		Get-ChildItem -Filter "alive.aspx" -Recurse | Rename-Item -NewName {$_.name -replace '.aspx','.aspx_bleeding' }
	}
	
	if($toDo -eq "endBleed")
	{
		Write-Host "Removing tags on all alive.html and alive.aspx files in ${searchDir}..." 
		cd $searchDir
		Get-ChildItem -Filter "alive.html*" -Recurse | Rename-Item -NewName {$_.name -replace '.html_bleeding','.html' }
		Get-ChildItem -Filter "alive.aspx*" -Recurse | Rename-Item -NewName {$_.name -replace '.aspx_bleeding','.aspx' }
	}
	
	Write-Host "Process complete."
}