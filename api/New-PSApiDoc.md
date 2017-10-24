

# New-PSApiDoc

Generates the documentation for a specific module.
## Syntax

    New-PSApiDoc [-ModuleName] <String> [-Path] <String> [<CommonParameters>]


## Description

Generates the documentation for a specific module.





## Parameters

    
    -ModuleName <String>
_The name of the module for which the documentation should be generated._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Path <String>
_The Path where the documentation should be written to._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-PSApiDoc -ModuleName Dummy -Path "${env:TEMP}\DummyDoc"

Generate the documentation for the "Dummy" module to a temp directory.





























