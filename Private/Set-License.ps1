function Set-License {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .PARAMETER UserUPN
        Specifies the ID (as UPN) of a user in Azure AD.
    .PARAMETER License
        Select the licensing plan for your tenant. 
        After creating your Office 365 E5 and Microsoft 365 E5 trial subscription you would be able choose between SPE_E5 and ENTERPRISEPREMIUM. 
        Default is SPE_E5 as it includes the ENTERPRISEPREMIUM license plan.
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
        $UserUPN,

        # License
        [Parameter(Mandatory)]
        [string]
        $License
    )

    # Assign license
    $ObjLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $ObjLicense.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $License -EQ).SkuID
    $ObjLicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $ObjLicensesToAssign.AddLicenses = $ObjLicense
    Set-AzureADUserLicense -ObjectId $UserUPN -AssignedLicenses $ObjLicensesToAssign
}