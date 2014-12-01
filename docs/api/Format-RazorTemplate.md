
# Format-RazorTemplate

Renders the specified Razor template.

## Syntax

    Format-RazorTemplate [-Template] <String> [[-Model] <Object>] [<CommonParameters>]


## Description

Renders the specified Razor template
with an optional model.





## Parameters

    
    -Template <String>


A Razor template.





Required?  true

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false

    
    
    -Model <Object>


A model to use in the template.





Required?  false

Position? 2

Default value? 

Accept pipeline input? false

Accept wildchard characters? false

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Render-RazorTemplate -Template "Hello World!"

Output: Hello World!




























### -------------------------- EXAMPLE 2 --------------------------
    @foreach(var i in Model){<li>@i</li>}</ul>" (0..3)

Output: <ul><li>0</li><li>1</li><li>2</li><li>3</li></ul>





























