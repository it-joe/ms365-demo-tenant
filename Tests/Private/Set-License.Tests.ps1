<# $ModuleManifestName = 'MS365DemoTenant.psd1'
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
        
    Context "Set-License" {

        It "Adds license for a user" {
                
            # Arrange
            Mock -CommandName New-Object -MockWith {
                $testlic = New-MockObject -Type Microsoft.Open.AzureAD.Model.AssignedLicense
                $AddMemberParams = @{
                    MemberType = "NoteProperty"
                    Name       = 'SkuId'
                    Value      = "SPE_E5"
                    Force      = $true
                }
                
                $testlic | Add-Member @AddMemberParams
                return $testlic
            }            
        
            Mock -CommandName Get-AzureADSubscribedSku -MockWith { 
                #return [PSCustomObject]@{
                #    SkuID = "SPE_E5"
                #}
            }

            Mock -CommandName New-Object -MockWith { 
                $testlic = New-MockObject -Type Microsoft.Open.AzureAD.Model.AssignedLicenses
                $AddMemberParams = @{
                    MemberType = "NoteProperty"
                    Name       = 'AddLicenses'
                    Value      = "SPE_E5"
                    Force      = $true
                }
                
                $testlic | Add-Member @AddMemberParams
                return $testlic
            }
            Mock -CommandName Set-AzureADUserLicense -MockWith { }

            # Act
            $SplatAct = @{ 
                UserUPN = "jane.doe@contoso.com"
                License = "SPE_E5"
            }
            Set-License @SplatAct

            # Assert
            Assert-MockCalled -CommandName New-Object -Exactly 2
            Assert-MockCalled -CommandName Get-AzureADSubscribedSku -Exactly 1
            Assert-MockCalled -CommandName Set-AzureADUserLicense -Exactly 1
        }
    }
} #>