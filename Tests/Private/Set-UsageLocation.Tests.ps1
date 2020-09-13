$ModuleManifestName = 'MS365DemoTenant.psd1'
$ModuleRoot = (Get-Item $PSScriptRoot).Parent.Parent.FullName
$ModuleManifestPath = Join-Path $ModuleRoot -ChildPath $ModuleManifestName

if (Get-Module MS365DemoTenant) {
    Remove-Module MS365DemoTenant
    Import-Module $ModuleManifestPath
}
else {
    Import-Module $ModuleManifestPath
}


InModuleScope MS365DemoTenant {
    Describe "MS365DemoTenant" { 
        Context "Set-UsageLocation" {
            It "Assign usage location for user account" {
            
                # Arrange
                Mock -CommandName Set-AzureADUser -MockWith { }

                # Act
                $SplatAct = @{ 
                    UserUPN       = "jane.doe@contoso.com"
                    UsageLocation = "DE"
                }
                Set-UsageLocation @SplatAct

                # Assert
                Assert-MockCalled -CommandName Set-AzureADUser -Exactly 1
            }
        }
    }
}