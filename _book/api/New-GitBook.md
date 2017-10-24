

# New-GitBook

New-GitBook builds a GitBook
## Syntax

    New-GitBook [-GitBookPath] <String> [-TempPath] <String> [[-UserName] <String>] [[-Password] <String>] [-Buildserver] [<CommonParameters>]


## Description

New-GitBook builds a GitBook without any system wide requirments.
In detail New-GitBook performs following tasks:
* Fixing npm bugs
* Installing GitBook in a TempPath
* If on a build-server, credentials will be stored in a local _netrc in temp path
* Install all npm modules of the book





## Parameters

    
    -GitBookPath <String>
_The path to the GitBook to build. (Gitbook build outputs to $GitBookPath\_book.)_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -TempPath <String>
_A local temporary path, to use for GitBook and as USEREPROFILE on build server._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -UserName <String>
_The UserName for Git repository_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    
    
    -Password <String>
_The Password for Git repository_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false |  | false | false |


----

    
    
    -Buildserver <SwitchParameter>
_If $true, credentials will be written to _netrc and some hacks done to solve problems with x86 and x64 problems.
The problem is that the USERPROFILE of the Teamcity Agent under C:\Windows\system32 is
and therefore it is different under x86 or x64_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false | False | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-GitBook ./docs ./temp user pw -Buildserver































