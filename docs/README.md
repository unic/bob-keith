<div class="chapterlogo">![Keith](Keith-Chapman-sketch.png)</div>
# Keith

Keith Chapman is the writer of the TV serie Bob the Builder. In our Bob world, Keith is responsible for the generation of an API documentation for PowerShell based machines.

To integrate Keith in a bob machine, simply add a paket dependency to "Unic.Bob.Keith" and add the following PowerShell script to the root of the repository:

    $PSScriptRoot = split-path -parent $MyInvocation.MyCommand.Definition

    $module = "MyModuleName"

    Import-Module "$PSScriptRoot\packages\Unic.Bob.Keith\Keith"
    Import-Module "$PSScriptRoot\src\$module" -Force

    New-PsDoc -Module $module -Path "$PSScriptRoot\docs\" -OutputLocation "$PSScriptRoot\docs-generated"

    gitbook build "$PSScriptRoot\docs-generated\"

Execute the Script each time you want to generate the docs.

## Requirments

To generate the docs you need to have [GitBook](https://github.com/GitbookIO/gitbook) installed.
