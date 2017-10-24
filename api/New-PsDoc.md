

# New-PsDoc

Generates a new documentation for a PowerShell module.
## Syntax

    New-PsDoc [-Path] <String> [-OutputLocation] <String> [[-Module] <String>] [<CommonParameters>]


## Description

Generates a new documentation for a PowerShell module,
by merging the handwritten and the API documentation.





## Parameters

    
    -Path <String>
_The path to the handwritten documentation._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -OutputLocation <String>
_The path to a folder where the generated documentation should be written._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Module <String>
_The name of the PowerShell module, for which the API doc should be generated._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-PsDoc -Path .\docs -OutputLocation .\docs-generated -Module keith































