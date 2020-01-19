
# Define paths for public and private function definition files
$FunctionPaths = @(
    [System.IO.Path]::Combine($PSScriptRoot, 'Public'),
    [System.IO.Path]::Combine($PSScriptRoot, 'Private')
)

# Dot source function definition files
Get-ChildItem -File -Recurse -Filter '*.ps1' -Path $FunctionPaths -PipelineVariable 'File' | ForEach-Object {
    try { 
        . $File.Fullname
    }
    catch {
        Write-Error -Message "Failed to import file $( $File.FullName ): $( $Global:Error[0] )"
    }
}

Export-ModuleMember '*-Sonarr*', '*-Radarr*'
