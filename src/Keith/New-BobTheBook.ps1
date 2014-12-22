function New-BobTheBook
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $OutputLocation,
        [Parameter(Mandatory=$true)]
        [string] $Username,
        [Parameter(Mandatory=$true)]
        [string] $Password



    )
    Process
    {
        Write-Verbose "Remove content of $OutputLocation"
        rm $OutputLocation\* -Recurse -Force
        $bookDir = Join-Path $OutputLocation "book"

        mkdir $bookDir
        mkdir "$bookDir\assets"

        "#Bob the book" | Out-File "$OutputLocation\README.md" -Encoding ascii

        $machines = ConvertFrom-Json (Get-Content $PSScriptRoot\BobTheBook.json -Raw)
        $reposPath = Join-Path $OutputLocation "repos"
        mkdir $reposPath

        $cloneOptions = New-Object LibGit2Sharp.CloneOptions
        $credentials = New-Object LibGit2Sharp.UsernamePasswordCredentials
        $credentials.Username = $Username
        $credentials.Password = $Password
        $cloneOptions.CredentialsProvider = {$credentials }

        foreach($machine in $machines) {
            $name = $machine.name
            $folder = Join-Path $reposPath $name
            [LibGit2Sharp.Repository]::Clone($machine.url, $folder, $cloneOptions)

            $repo = New-Object LibGit2Sharp.Repository $folder
            $repo.Branches["refs/remotes/origin/develop"].Checkout()
            $repo.Dispose();

            Push-Location $folder
            & "$PSScriptRoot\..\..\.paket\paket.exe" "restore"
            Pop-Location

            $docsFolder = Join-Path $folder "generated-docs"
            $modulePath = Join-Path $folder $machine.modulePath
            Import-Module (Join-Path $modulePath $machine.module)
            New-PSDoc "$folder\docs" $docsFolder $machine.module -Verbose

            foreach($file in (ls $docsFolder -Recurse | ? { $_.Extension -eq  ".md" })) {
                $currentFolder = $bookDir + (Split-Path $file.FullName).Replace($docsFolder, "")
                if(-not (Test-Path $currentFolder)) {
                    mkdir $currentFolder | Out-Null
                }
                cp $file.FullName "$currentFolder\"
            }



        }

        return
        $guys | ? {
            Test-Path "$($_.FullName)\docs-generated"
        } | % {
            $name = $_.Name.Replace("bob-", "")
            $moduleFolder = "$OutputLocation\$name"
            mkdir "$OutputLocation\$name"


            $basePath = "$($_.FullName)\docs-generated"
            Write-Host $basePath
            ls $basePath -Recurse | ? {
                $_.Extension -eq  ".md"
            } | % {
                $dir = $moduleFolder + (Split-Path $_.FullName).Replace($basePath, "")
                Write-Host $dir
                if(-not (Test-Path $dir)) {
                    mkdir $dir | Out-Null
                }
                cp $_.FullName "$dir\"
            }

            $assets = "$($_.FullName)\docs-generated\assets\"
            if(Test-Path $assets) {
                cp "$assets\*" "$OutputLocation\assets" -Recurse
            }
            "* [$name]($name/README.md)" | Out-File "$OutputLocation\SUMMARY.md" -Append -encoding ascii
            $content = Get-Content "$($_.FullName)\docs-generated\SUMMARY.md"
            $content = foreach($line in $content) {
                if($line.Trim() -ne "") {
                    "    " + ($line -replace "(\[.*\])\((.*)\)", ('$1(' + $name +'/$2)'))
                }
            }
            $content | Out-File "$OutputLocation\SUMMARY.md" -Append -encoding ascii
        }

        gitbook build .\bob-thebook
    }
}
