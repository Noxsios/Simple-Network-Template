# WIP
# add to profile

function Invoke-SNT {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.IO.FileInfo]$TemplateFile
    )
    
    $folder = (Get-Item -LiteralPath $TemplateFile).Directory.FullName

    $titles = ((Get-Content ($folder + "\variables.csv"))[0] -split ',')
    # ignore the first element, which is always VARIABLES
    # all other elements are the device names
    $titles = $titles[1..$titles.Length]

    Write-Host "------"

    for ($k = 0; $k -lt $titles.Length; $k++) {
        # build the config file for each device in the first row of variables.csv
        $configfile = $folder + "\" + $templatefile.BaseName + "_config_" + $titles[$k] + $templatefile.Extension
        Copy-Item -Path $templatefile -Destination $configfile -Force
                    
        # grab the metadata variables
        $meta = Import-Csv ($folder + "\variables.csv")

        for ($i = 0; $i -lt $meta.Count; $i++) {
            $row = $meta[$i]
            $col = $titles[$k]
            $value = $row.$col
            $tag = "{{" + $meta.VARIABLES[$i] + "}}"
            Write-Host ("Replacing $tag in") $titles[$k] "with" $value
            ((Get-Content -Path $configfile) -replace [RegEx]::Escape($tag), ($value) ) | Set-Content -Path $configfile
        }

        Write-Host "------"
    }
}