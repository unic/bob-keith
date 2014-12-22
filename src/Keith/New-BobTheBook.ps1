function New-BobTheBook
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $OutputLocation,
        [Parameter(Mandatory=$true)]
        [string] $Username,
        [Parameter(Mandatory=$true)]
        [string] $Password,
        [Parameter(Mandatory=$true)]
        [string] $BobTheBook
    )
    Process
    {
        Write-Verbose "Remove content of $OutputLocation"
        rm $OutputLocation\* -Recurse -Force
        $bookDir = Join-Path $OutputLocation "book"

        mkdir $bookDir
        mkdir "$bookDir\assets"

        $machines = ConvertFrom-Json (Get-Content $PSScriptRoot\BobTheBook.json -Raw)
        $reposPath = Join-Path $OutputLocation "repos"
        mkdir $reposPath

        $cloneOptions = New-Object LibGit2Sharp.CloneOptions
        $credentials = New-Object LibGit2Sharp.UsernamePasswordCredentials
        $credentials.Username = $Username
        $credentials.Password = $Password
        $cloneOptions.CredentialsProvider = {$credentials }

        $summary = ""

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
            $files = (ls $docsFolder -Recurse |
            ? { ".md", ".jpg", ".jpg", ".jpeg", ".png", ".gif" -contains $_.Extension   })
            foreach($file in $files) {
                $currentFolder = "$bookDir\$name"  + (Split-Path $file.FullName -Parent).Replace($docsFolder, "")
                if(-not (Test-Path $currentFolder)) {
                    mkdir $currentFolder | Out-Null
                }
                cp $file.FullName "$currentFolder\"
            }

            $assets = "$docsFolder\assets\"
            if(Test-Path $assets) {
                cp "$assets\*" "$bookDir\assets" -Recurse
            }

            $summary += "* [$name]($name/README.md)"
            $thisSummary = Get-Content "$docsFolder\SUMMARY.md"
            $editedSummary = foreach($line in $thisSummary) {
                if($line.Trim() -ne "") {
                    "    " + ($line -replace "(\[.*\])\((.*)\)", ('$1(' + $name +'/$2)')) + "`n"
                }
            }
            $summary += $editedSummary
        }

        cp "$BobTheBook\*" $bookDir -Recurse
        $originalSummary = Get-Content "$bookDir\SUMMARY.md" -Raw
        $summary = $originalSummary.Replace("##MACHINES##", $summary)
        $summary | Out-File "$bookDir\SUMMARY.md" -Encoding UTF8
        gitbook build $bookDir
    }
}
