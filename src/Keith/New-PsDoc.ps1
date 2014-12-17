function New-PsDoc
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Path,
        [Parameter(Mandatory=$true)]
        [string] $OutputLocation,
        [string] $Module
    )
    Process
    {
        if(-not (Test-Path $OutputLocation)){
            mkdir $OutputLocation | Out-Null
        }
        cp $Path\* $OutputLocation
        if($Module) {
            New-PsApiDoc -Path $OutputLocation -Module $Module
        }
    }
}
