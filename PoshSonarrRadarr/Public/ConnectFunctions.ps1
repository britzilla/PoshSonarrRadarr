
function Connect-SonarrRadarr {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)] [string] $ConfigFilePath,
        [Parameter(Mandatory=$false)] [ValidateSet('Sonarr', 'Radarr')] [string[]] $Type = @( 'Sonarr', 'Radarr' ),
        [Parameter(Mandatory=$false)] [switch] $SkipConnectivityTest = $false
    )
    Import-ConfigFile $ConfigFilePath
    if( $SkipConnectivityTest -eq $true ) {
        Write-Warning 'Skipping connectivity test'
    }
    else {
        if( 'Sonarr' -in $Type ) {
            $SonarrStatus = Get-SonarrSystemStatus
            if( $SonarrStatus.StatusDescription -eq 'OK' ) {
                Write-Verbose 'Successfully authetnicated with Sonarr'
            }
            else {
                Write-Warning "Sonarr connection test failed; StatusDescription: $( $SonarrStatus.StatusDescription ) Reason: $( $SonarrStatus.Content )"
            }
        }
        if( 'Radarr' -in $Type ) {
            $RadarrStatus = Get-RadarrSystemStatus
            if( $RadarrStatus.StatusDescription -eq 'OK' ) {
                Write-Verbose 'Successfully authetnicated with Radarr'
            }
            else {
                Write-Warning "Radarr connection test failed; StatusDescription: $( $RadarrStatus.StatusDescription ) Reason: $( $RadarrStatus.Content )"
            }
        }
    }
}
