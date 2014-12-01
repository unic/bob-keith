$ErrorActionPreference = "Stop"
$PSScriptRoot = Split-Path  $script:MyInvocation.MyCommand.Path

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1 | Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *

function ResolvePath() {
    param($PackageId, $RelativePath)
    $paths = @("$PSScriptRoot\..\..\packages", "$PSScriptRoot\..\tools")
    foreach($packPath in $paths) {
        $path = Join-Path $packPath "$PackageId\$RelativePath"
        if((Test-Path $packPath) -and (Test-Path $path)) {
            Resolve-Path $path
            return
        }
    }
    Write-Error "No path found for $RelativePath in package $PackageId"
}

[System.Reflection.Assembly]::LoadFrom((ResolvePath -PackageId "Microsoft.AspNet.Razor" -RelativePath "lib\net40\System.Web.Razor.dll"))
