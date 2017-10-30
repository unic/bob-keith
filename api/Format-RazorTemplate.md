


# Format-RazorTemplate

Renders the specified Razor template.
## Syntax

    Format-RazorTemplate [-Template] <String> [[-Model] <Object>] [<CommonParameters>]


## Description

Renders the specified Razor template
with an optional model.
Based on: https://github.com/knutkj/misc/blob/master/PowerShell/Razor/Render-RazorTemplate.ps1





## Parameters

    
    -Template <String>
_The content of a Razor template._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Model <Object>
_A model to use in the template._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Render-RazorTemplate -Template "Hello World!"

Output: Hello World!




























### -------------------------- EXAMPLE 2 --------------------------
    @foreach(var i in Model){<li>@i</li>}</ul>" (0..3)

Output: <ul><li>0</li><li>1</li><li>2</li><li>3</li></ul>





























