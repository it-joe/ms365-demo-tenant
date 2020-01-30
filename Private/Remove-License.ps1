function Remove-License {
    <#
    .SYNOPSIS
        Removes currently assigned licenses from user account.
    .DESCRIPTION
        Removes currently assigned licenses from user account.
    .PARAMETER UserUPN
        Specifies the ID (as UPN) of a user in Azure AD.
    .EXAMPLE
        PS C:\> Remove-License -UserUPN johndoe@contoso.onmicrosoft.com
        Removes currently assigned licenses from johndoe@contoso.onmicrosoft.com.
    .INPUTS
        None. You cannot pipe objects to Remove-License.
    .OUTPUTS
        None. Remove-License does not generate any output.
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
}