
function Get-SonarrEpisode {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,  Position=0)] [int] $SeriesId,
        [Parameter(Mandatory=$false, Position=1, ValueFromPipeline=$true)] [int[]] $EpisodeId
    )
    begin {
        $Query = @{ seriesId = $SeriesId }
    }
    process {
        if( $PSBoundParameters.ContainsKey('EpisodeId') ) {
            $EpisodeId.ForEach{ "/episode/$_" } | Invoke-ApiMethod Sonarr -Query $Query
        }
        else {
            Invoke-ApiMethod Sonarr -Path '/episode' -Query $Query
        }
    }
}

function Get-SonarrEpisodeFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,  Position=0)] [int] $SeriesId,
        [Parameter(Mandatory=$false, Position=1, ValueFromPipeline=$true)] [int[]] $EpisodeId
    )
    begin {
        $Query = @{ seriesId = $SeriesId }
    }
    process {
        $Query = @{ seriesId = $SeriesId }
        if( $PSBoundParameters.ContainsKey('EpisodeId') ) {
            $EpisodeId.ForEach{ "/episodeFile/$_" } | Invoke-ApiMethod Sonarr -Query $Query
        }
        else {
            Invoke-ApiMethod Sonarr -Path '/episodeFile' -Query $Query
        }
    }
}
