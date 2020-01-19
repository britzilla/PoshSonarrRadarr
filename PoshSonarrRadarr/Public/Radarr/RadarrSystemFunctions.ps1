
function Get-RadarrSystemStatus {
    [CmdletBinding()]
    param()
    Invoke-ApiMethod Radarr -Path '/system/status'
}
