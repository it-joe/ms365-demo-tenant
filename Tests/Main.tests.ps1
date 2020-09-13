
$ModuleManifestName = 'MS365DemoTenant.psd1'
$ModuleRoot = (Get-Item $PSScriptRoot).Parent.FullName
$ModuleManifestPath = Join-Path $ModuleRoot -ChildPath $ModuleManifestName

if (Get-Module MS365DemoTenant) {
    Remove-Module MS365DemoTenant
    Import-Module $ModuleManifestPath
}
else {
    Import-Module $ModuleManifestPath
}

Describe 'Module Manifest Tests' {

    $Scripts = Get-ChildItem $ModuleRoot -Include *.ps1, *.psm1, *.psd1 -Recurse

    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }

    # TestCases are splatted to the script so we need hashtables
    $testCase = $scripts | Foreach-Object { @{file = $_ } }
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)

        $file.fullname | Should Exist

        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }
}