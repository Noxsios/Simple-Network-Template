BeforeAll { 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')

    Copy-Item -Recurse -Path ./sample -Destination ./sample_output
}

Describe 'Invoke-Simple-Network-Template' {
    It 'Given sample parameters, performs operation' {
        Invoke-SNT -TemplateFile ./sample_output/template_sample.txt
        $configFiles = Get-ChildItem ./sample_output | Where-Object { $_.Name -Like '*_config_*' }
        $configFiles.Count | Should -Be 2
    }
}

AfterAll {
    Remove-Item -Path ./sample_output -Recurse -Force
}