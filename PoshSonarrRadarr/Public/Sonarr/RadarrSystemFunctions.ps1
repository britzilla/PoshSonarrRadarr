
function Get-SonarrSystemStatus {
    [CmdletBinding()]
    param()
    Invoke-ApiMethod Sonarr -Path '/system/status'
}
