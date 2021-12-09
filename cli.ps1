# WIP
# add to profile

function Invoke-Simple-Network-Template {
    [CmdletBinding()]
    param (
        
    )
    
    $templatefile = Get-Item -LiteralPath $item
    $folder = ($templatefile).Directory.FullName

    if ($templatefile -is [System.IO.DirectoryInfo]) {
        Write-Host ("ERROR: DIRECTORY PROVIDED")
    }
    else {
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
                $tag = "{{" + $meta.VARIABLES[$i] + "}}"
                Write-Host ("Replace $tag in") $titles[$k] "with" $row.$col "."
            
                        ((Get-Content -Path $configfile) -replace [RegEx]::Escape("{{" + $row.VARIABLES + "}}"), ($meta.$col) ) | Set-Content -Path $configfile
            }

            Write-Host "------"
        }
    }
}