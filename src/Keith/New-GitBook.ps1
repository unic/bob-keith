<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function New-GitBook
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $GitBookPath,
        [Parameter(Mandatory=$true)]
        [string] $TempPath,
        [string] $UserName,
        [string] $Password,
        [switch] $Buildserver
    )
    Process
    {
        # Workaround for node.js bug
        if(-not (Test-Path $env:APPDATA\npm)) {
            mkdir $env:APPDATA\npm
        }

        if(-not (Test-Path $TempPath)) {
            mkdir $TempPath
        }

        if($buildserver) {
            $localTempPath = "$tempPath\local"
            $oldProfile = $env:USERPROFILE
            $env:USERPROFILE = $localTempPath

            $cachePath = "${env:TEMP}\npm-cache"
            npm set cache $cachePath
        }

        Push-Location $TempPath
        Resolve-Path .
        npm install gitbook
        Pop-Location

        if($buildserver) {
            $file = "machine git.unic.com`r`n" +
                     "login $username`r`n" +
                     "password $password`r`n" + ""

             $file | Out-File "$localTempPath\_netrc" -Encoding ascii
        }

        Push-Location $GitBookPath
        npm install
        & "$TempPath\node_modules\.bin\gitbook.cmd" build
        Pop-Location

        if($buildserver) {
            rm "$localTempPath" -Recurse
            $env:USERPROFILE = $oldProfile
        }
    }
}
