function New-PSApiDoc
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $ModuleName,
        [Parameter(Mandatory = $true)]
        [string] $Path
    )
    Process
    {
        $moduleData = Get-Module -Name $ModuleName
        $commands = $moduleData.ExportedCommands | Select-Object -ExpandProperty 'Keys' | % {Get-Help $_ -Detailed}
        $basePath = Resolve-Path "$PSScriptRoot\..\Templates"
        $razorFiles = ls $basePath -Filter "*.cshtml" -Exclude "_*.cshtml" -Recurse
        foreach($razorFile in $razorFiles) {
            $template = Get-Content $razorFile.FullName -Raw
            $relativePath = $razorFile.FullName.Replace($basePath, "")
            $relativePath = $relativePath.Trim("\")
            $relativePathWithoutExtesion = $relativePath.TrimEnd(".cshtml")
            $outPath = "$Path\$relativePathWithoutExtesion.md"
            Format-RazorTemplate $template @{"Module"= $moduleData; "Commands"= $commands} | Out-File $outPath -Encoding ASCII
        }

        $apiPath = "$Path\api\"
        if(Test-Path $apiPath) {
            rm $apiPath -Recurse
        }
        mkdir $apiPath | Out-Null

        foreach($command in $commands) {
            $template = Get-Content "$basePath\_command.cshtml" -Raw
            $outPath = "$apiPath\$($command.Name).md"
            Format-RazorTemplate $template @{"Module"= $moduleData; "Command"= $command} | Out-File $outPath -Encoding ASCII
        }
    }
}
