$PSScriptRoot = split-path -parent $MyInvocation.MyCommand.Definition

Import-Module "$PSScriptRoot\src\Keith" -Force

New-PSApiDoc -ModuleName Keith -Path "$PSScriptRoot\docs\"

gitbook build "$PSScriptRoot\docs\"
