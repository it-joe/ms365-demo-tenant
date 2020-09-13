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
        
    Context "Remove-License (1st call)" {

        It "Removes currently assigned licenses from user account (1st call)" {
                
            # Arrange
            Mock -CommandName New-Object -MockWith { 
                New-MockObject -Type Microsoft.Open.AzureAD.Model.AssignedLicenses
            }
            Mock -CommandName Get-AzureADSubscribedSku -MockWith { 
                return [PSCustomObject]@{
                    SkuID = "SPE_E5"
                }
            }
            Mock -CommandName Set-AzureADUserLicense -MockWith { }

            # Act
            $SplatAct = @{ 
                UserUPN = "jane.doe@contoso.com"
            }
            Remove-License @SplatAct

            # Assert
            Assert-MockCalled -CommandName New-Object -Exactly 1
            Assert-MockCalled -CommandName Get-AzureADSubscribedSku -Exactly 1
            Assert-MockCalled -CommandName Set-AzureADUserLicense -Exactly 1
        }
    }
}