function Remove-License {
    <#
    .SYNOPSIS
        Remove currently assigned licenses from user account.
    .DESCRIPTION
        Remove currently assigned licenses from user account
    .PARAMETER UserUPN
        Specifies the ID (as UPN) of a user in Azure AD.
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [CmdletBinding()]
    param (
        # User UPN
        [Parameter(Mandatory)]
        [string]
        $UserUPN
    )

    $ObjLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $SkuIDs = (Get-AzureADSubscribedSku).SkuID
    foreach ($SkuID in $SkuIDs) {
        $ObjLicense.RemoveLicenses = $SkuID
        try {
            Set-AzureADUserLicense -ObjectId $userUPN -AssignedLicenses $ObjLicense
        }
        catch {
            continue
        }
    }
    
    <# $licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $Licenses.RemoveLicenses =  (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $planName -EQ).SkuID
    Set-AzureADUserLicense -ObjectId $userUPN -AssignedLicenses $licenses #>
}