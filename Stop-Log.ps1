Function Stop-Log {
  <#
  .SYNOPSIS
    Write closing data to log file & exits the calling script
  .DESCRIPTION
    Writes finishing logging data to specified log file and then exits the calling script
  .PARAMETER LogPath
    Mandatory. Full path of the log file you want to write finishing data to. Example: C:\Windows\Temp\Test_Script.log
  .PARAMETER NoExit
    Optional. If parameter specified, then the function will not exit the calling script, so that further execution can occur (like Send-Log)
  .PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.
  .INPUTS
    Parameters above
  .OUTPUTS
    None
  .NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  10/05/12
    Purpose/Change: Initial function development.
    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  19/05/12
    Purpose/Change: Added debug mode support.
    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  01/08/12
    Purpose/Change: Added option to not exit calling script if required (via optional parameter).
    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.
    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Changed -NoExit parameter to switch type so no longer need to specify $True or $False (see example for info).
    Version:        1.5
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.
    Author:         Chris Taylor
    Creation Date:  9/2/2016
    Purpose/Change: Added verbose output option.

  .LINK
    http://9to5IT.com/powershell-logging-v2-easily-create-log-files
  .EXAMPLE
    Stop-Log -LogPath "C:\Windows\Temp\Test_Script.log"
    Writes the closing logging information to the log file and then exits the calling script.
    Note: If you don't specify the -NoExit parameter, then the script will exit the calling script.
  .EXAMPLE
    Stop-Log -LogPath "C:\Windows\Temp\Test_Script.log" -NoExit
    Writes the closing logging information to the log file but does not exit the calling script. This then
    allows you to continue executing additional functionality in the calling script (such as calling the
    Send-Log function to email the created log to users).
  #>

  [CmdletBinding()]

  Param (
    [Parameter(Mandatory=$true,Position=0)][string]$LogPath,
    [Parameter(Mandatory=$false,Position=1)][switch]$NoExit,
    [Parameter(Mandatory=$false,Position=2)][switch]$ToScreen,
    [Parameter(Mandatory=$true,Position=3)][string]$Status
  )

  Process {
    Add-Content -Force -Path $LogPath -Value ""
    Add-Content -Force -Path $LogPath -Value "***************************************************************************************************"
    Add-Content -Force -Path $LogPath -Value "Finished processing at [$([DateTime]::Now)] $(New-TimeSpan -Start $Script:ScriptStartTime -End $(Get-Date)) Status: $Status"
    Add-Content -Force -Path $LogPath -Value "***************************************************************************************************"
    Add-Content -Force -Path $LogPath -Value "___________________________________________________________________________________________________"

    #Write to screen for debug mode
    Write-Debug ""
    Write-Debug "***************************************************************************************************"
    Write-Debug "Finished processing at [$([DateTime]::Now)] $(New-TimeSpan -Start $Script:ScriptStartTime -End $(Get-Date)) Status: $Status"
    Write-Debug "***************************************************************************************************"

    #Write to screen for Verbose mode
    Write-Verbose ""
    Write-Verbose "***************************************************************************************************"
    Write-Verbose "Finished processing at [$([DateTime]::Now)] $(New-TimeSpan -Start $Script:ScriptStartTime -End $(Get-Date)) Status: $Status"
    Write-Verbose "***************************************************************************************************"


    #Write to scren for ToScreen mode
    If ( $ToScreen -eq $True ) {
      Write-Output ""
      Write-Output "***************************************************************************************************"
      Write-Output "Finished processing at [$([DateTime]::Now)] $(New-TimeSpan -Start $Script:ScriptStartTime -End $(Get-Date)) Status: $Status"
      Write-Output "***************************************************************************************************"
    }
    
    $sLogCreated = 0
    
    #Exit calling script if NoExit has not been specified or is set to False
    If( !($NoExit) -or ($NoExit -eq $False) ){
      Exit
    }
  }
}
