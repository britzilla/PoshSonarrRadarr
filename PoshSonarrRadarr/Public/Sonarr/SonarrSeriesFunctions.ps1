
function Get-SonarrSeries {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true)] [int[]] $SeriesId
    )
    process {
        if( $PSBoundParameters.ContainsKey('SeriesId') ) {
            $SeriesId.ForEach{ "/series/$_" } | Invoke-ApiMethod Sonarr
        }
        else {
            Invoke-ApiMethod Sonarr -Path '/series'
        }
    }
}

function New-SonarrSeries {
    [CmdletBinding()]
    param()
    Write-Warning 'New-SonarrSeries not yet implemented'
}

function Update-SonarrSeries {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)] [int] $SeriesId,
        [Parameter(Mandatory=$true)] [PSObject] $SeriesObject
    )
    Invoke-ApiMethod Sonarr -Path "/series/$SeriesId" -Method Put -Body $SeriesObject
}

function Remove-SonarrSeries {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)] [int[]] $SeriesId,
        [Parameter(Mandatory=$false)] [switch] $DeleteFiles = $false
    )
    process {
        $SeriesId.ForEach{ "/series/$_" } | Invoke-ApiMethod Sonarr -Method Delete -Query @{ deleteFiles = $DeleteFiles }
    }
}

function Search-SonarrSeries {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)] [string] $Term
    )
    Invoke-ApiMethod Sonarr -Path '/series/lookup' -Query @{ term = [System.Web.HttpUtility]::UrlEncode($Term) }
}
