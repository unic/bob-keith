

# New-PSApiDoc

Generates the documentation for a specific module.
## Syntax

    New-PSApiDoc [-ModuleName] <String> [-Path] <String> [<CommonParameters>]


## Description

Generates the documentation for a specific module.





## Parameters

    
    -ModuleName <String>

The name of the module for which the documentation should be generated.





Required?  true

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Path <String>

The Path where the documentation should be written to.





Required?  true

Position? 2

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-PSApiDoc -ModuleName Dummy -Path "${env:TEMP}\DummyDoc"

Generate the documentation for the "Dummy" module to a temp directory.





























