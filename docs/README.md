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

## Bob - The book
_Bob - The Book_ is the full documentation of Bob. To create a new edition use the [`New-BobTheBook`](api/New-BobTheBook.md) cmdlet.
It creates a book based on the [general documentation](https://git.unic.com/projects/SCMBOB/repos/bob-thebook/browse) and the documentation of all Bob machines.