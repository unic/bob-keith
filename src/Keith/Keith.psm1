$ErrorActionPreference = "Stop"

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1 | Foreach-Object{ . ([scriptblock]::Create([io.file]::ReadAllText($_.FullName))) }
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

[System.Reflection.Assembly]::Load([System.IO.File]::ReadAllBytes(
(ResolvePath -PackageId "Microsoft.AspNet.Razor" -RelativePath "lib\net45\System.Web.Razor.dll")))

[System.Reflection.Assembly]::LoadFile((ResolvePath -PackageId "LibGit2Sharp" -RelativePath "lib\net40\LibGit2Sharp.dll"))
