
function Get-RadarrMovie {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true)] [int[]] $MovieId
    )
    process {
        if( $PSBoundParameters.ContainsKey('MovieId') ) {
            $MovieId.ForEach{ "/movie/$_" } | Invoke-ApiMethod Radarr
        }
        else {
            Invoke-ApiMethod Radarr -Path '/movie'
        }
    }
}

function New-RadarrMovie {
    [CmdletBinding()]
    param()
    Write-Warning 'New-RadarrMovie not yet implemented'
}

function Update-RadarrMovie {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)] [int] $MovieId,
        [Parameter(Mandatory=$true)] [PSObject] $MovieObject
    )
    Invoke-ApiMethod Radarr -Path "/movie/$MovieId" -Method Put -Body $MovieObject
}

function Remove-RadarrMovie {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)] [int[]] $MovieId,
        [Parameter(Mandatory=$false)] [switch] $DeleteFiles = $false
    )
    process {
        $MovieId.ForEach{ "/movie/$_" } | Invoke-ApiMethod Radarr -Method Delete -Query @{ deleteFiles = $DeleteFiles }
    }
}

function Search-RadarrMovie {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)] [string] $Term
    )
    Invoke-ApiMethod Radarr -Path '/movie/lookup' -Query @{ term = [System.Web.HttpUtility]::UrlEncode($Term) }
}
