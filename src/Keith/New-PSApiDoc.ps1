<#
.SYNOPSIS
Generates the documentation for a specific module.

.DESCRIPTION
Generates the documentation for a specific module.


.PARAMETER ModuleName
The name of the module for which the documentation should be generated.


.PARAMETER Path
The Path where the documentation should be written to.



.EXAMPLE
New-PSApiDoc -ModuleName Dummy -Path "${env:TEMP}\DummyDoc"

Generate the documentation for the "Dummy" module to a temp directory.



#>
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
            if($command.examples.example -is [PSObject]) {
                $command.examples.example = @($command.examples.example)
            }
            Format-RazorTemplate $template @{"Module"= $moduleData; "Command"= $command} | Out-File $outPath -Encoding ASCII
        }
    }
}
