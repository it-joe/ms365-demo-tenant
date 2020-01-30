function Set-License {
    <#
    .SYNOPSIS
        Adds license for a user.
    .DESCRIPTION
        Adds license for a user.
    .PARAMETER UserUPN
        Specifies the ID (as UPN) of a user in Azure AD.
    .PARAMETER License
        Select the licensing plan for your tenant. 
        After creating your Office 365 E5 and Microsoft 365 E5 trial subscription you would be able choose between SPE_E5 and ENTERPRISEPREMIUM. 
    .EXAMPLE
        PS C:\> Set-License -UserUPN johndoe@contoso.onmicrosoft.com -License SPE_E5
        Adds Microsoft 365 E5 (SPE_E5) license to user johndoe@contoso.onmicrosoft.com.
    .INPUTS
        None. You cannot pipe objects to Set-License.
    .OUTPUTS
        None. Set-License does not generate any output.
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