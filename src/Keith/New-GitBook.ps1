<#
.SYNOPSIS
New-GitBook builds a GitBook
.DESCRIPTION
New-GitBook builds a GitBook without any system wide requirments.
In detail New-GitBook performs following tasks:
* Fixing npm bugs
* Installing GitBook in a TempPath
* If on a build-server, credentials will be stored in a local _netrc in temp path
* Install all npm modules of the book

.PARAMETER GitBookPath
The path to the GitBook to build. (Gitbook build outputs to $GitBookPath\_book.)

.PARAMETER TempPath
A local temporary path, to use for GitBook and as USEREPROFILE on build server.

.PARAMETER UserName
The UserName for Git repository

.PARAMETER Password
The Password for Git repository

.PARAMETER Buildserver
If $true, credentials will be written to _netrc and some hacks done to solve problems with x86 and x64 problems.
The problem is that the USERPROFILE of the Teamcity Agent under C:\Windows\system32 is
and therefore it is different under x86 or x64

.EXAMPLE
New-GitBook ./docs ./temp user pw -Buildserver

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
            Write-Host "Set npm cache to ${env:TEMP}\npm-cache"
            $cachePath = "${env:TEMP}\npm-cache"
            npm set cache $cachePath
        }

        Push-Location $TempPath
        $currentPath = Resolve-Path .

        # Write npm config file to suppress warn logs
        # npm writes warnings to stderr stream, which is watched by Appveyor for build failure recognition
        # all measures to reroute stderr to stdout stream had no effect when used inside a ps module
        # (although rerouting worked in a ps cmd called by Appveyor directly).
        "loglevel=error" | Out-File "$currentPath\.npmrc" -Encoding UTF8

        npm install gitbook-cli
        Pop-Location

        if($buildserver) {
            $file = "machine github.com`r`n" +
                     "login $username`r`n" +
                     "password $password`r`n" + ""

             $file | Out-File "$localTempPath\_netrc" -Encoding ascii
        }

        Push-Location $GitBookPath
        & "$TempPath\node_modules\.bin\gitbook.cmd" install
        & "$TempPath\node_modules\.bin\gitbook.cmd" build
        Pop-Location

        if($buildserver) {
            rm "$localTempPath" -Recurse
            $env:USERPROFILE = $oldProfile
        }
    }
}
