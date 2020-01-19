
function Get-SonarrCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true)] [int[]] $CommandId
    )
    process {
        if( $PSBoundParameters.ContainsKey('CommandId') ) {
            $CommandId.ForEach{ "/command/$_" } | Invoke-ApiMethod Sonarr
        }
        else {
            Invoke-ApiMethod Sonarr -Path '/command'
        }
    }
}

function Invoke-SonarrDownloadedMoviesScan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)] [string] $Path,
        [Parameter(Mandatory=$true)] [string] $DownloadClientId,
        [Parameter(Mandatory=$true)] [ValidateSet('Move', 'Copy')] [string] $ImportMode
    )
    $ApiParam = @{
        Type   = 'Sonarr'
        Path   = '/command'
        Method = 'Post'
        Body   = ConvertTo-Json -Compress -InputObject @{
            path             = $Path
            name             = 'DownloadedEpisodesScan'
            downloadClientId = $DownloadClientId.ToUpper()
            importMode       = $ImportMode
        }
    }
    Invoke-ApiMethod @ApiParam
}
