
function Get-RadarrCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true)] [int[]] $CommandId
    )
    process {
        if( $PSBoundParameters.ContainsKey('CommandId') ) {
            $CommandId.ForEach{ "/command/$_" } | Invoke-ApiMethod Radarr
        }
        else {
            Invoke-ApiMethod Radarr -Path '/command'
        }
    }
}

function Invoke-RadarrDownloadedMovieScan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)] [string] $Path,
        [Parameter(Mandatory=$true)] [string] $DownloadClientId,
        [Parameter(Mandatory=$true)] [ValidateSet('Move', 'Copy')] [string] $ImportMode
    )
    $Body = [PSCustomObject] @{
        path             = $Path
        name             = 'DownloadedMoviesScan'
        downloadClientId = $DownloadClientId.ToUpper()
        importMode       = $ImportMode
    }
    Invoke-ApiMethod Radarr -Path '/command' -Method Post -Body $Body
}
