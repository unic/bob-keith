# Keith

To integrate Keith in a bob machine  simply add a paket dependency to "Unic.Bob.Keith" and add the following PowerShell script to the root of the repository:

	$PSScriptRoot = split-path -parent $MyInvocation.MyCommand.Definition

	$module = "MyModuleName"

	Import-Module "$PSScriptRoot\packages\Unic.Bob.Keith\Keith"
	Import-Module "$PSScriptRoot\src\$module" -Force

	New-PsDoc -Module $module -Path "$PSScriptRoot\docs\" -OutputLocation "$PSScriptRoot\docs-generated"

	gitbook build "$PSScriptRoot\docs-generated\"

Execute then the Script each time you want to generate the docs.

## Requirments

To generate the docs you need to have installed GitBook: https://github.com/GitbookIO/gitbook

## Bob - The book
_Bob - The Book_ is the full documentation of Bob. To create a new edition use the [`New-BobTheBook`](api/New-BobTheBook.md) cmdlet. 
