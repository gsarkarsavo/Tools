<#
This script is for stoppping, starting, or restarting windows services that match the filter provided.

Parameters:
filter - part fo the service name you want to search for
command - what you want to do (start, stop, restart)

NOTE: it is safe to run this script.  It prompts you with "are you sure" questions before doing anything.
#>
param([string]$filter, [string]$command)

if($command)
{
    $continue = "no"
    
    Get-WMIObject Win32_Service -Filter "Name LIKE '%$filter%'" | Foreach-Object{
        Write-Host Found $_.DisplayName -foreground green
    }
    
    Write-Host Are you sure you want to $command these services? yes or no -foreground yellow
    $continue = Read-Host
    
        if($continue -eq "yes")
        {    
            Get-WMIObject Win32_Service -Filter "Name LIKE '%$filter%'" | Foreach-Object{
        
            Write-Host ------------------------------------------------------------ -foreground cyan
        
            if($command -eq "stop")
            {    
                Write-Host Stopping $_.DisplayName ... -foreground gray
                Stop-Service $_.Name
                Write-Host done. -foreground green
            }
    
            if($command -eq "start")
            {    
                Write-Host Starting $_.DisplayName ... -foreground gray
                Start-Service $_.Name
                Write-Host done. -foreground green
            }
    
            if($command -eq "restart")
            {   
                Write-Host Stopping $_.DisplayName ... -foreground gray
                Stop-Service $_.Name 
                Write-Host Starting $_.DisplayName ... -foreground gray
                Start-Service $_.Name
                Write-Host done. -foreground green
            }
        }
    }
}
else
{
    Write-Host I have no idea what you want me to do. -foreground yellow
    Write-Host Tell me to start, stop, or restart. -foreground yellow
}