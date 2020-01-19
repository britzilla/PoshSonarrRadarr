
function Import-ConfigFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)] [string] $Path
    )
    if( -not [System.IO.File]::Exists($Path) ) {
        Write-Warning "No config file found at $Path"
    }
    else {
        Write-Verbose "Importing config file from $( Resolve-Path $Path )"
        $Script:Config = Import-PowerShellDataFile $Path
    }
}
