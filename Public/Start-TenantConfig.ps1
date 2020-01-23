function Start-TenantConfig {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .PARAMETER License
        Select the licensing plan for your tenant. 
        After creating your Office 365 E5 and Microsoft 365 E5 trial subscription you would be able choose between SPE_E5 and ENTERPRISEPREMIUM. 
        Default is SPE_E5 as it includes the ENTERPRISEPREMIUM license plan.
    .PARAMETER UsageLocation
        ISO 3166-1 alpha-2 country code.
        Before a license can be assigned to a user, the administrator has to specify the usage location property on the user. 
        Some Microsoft services are not available in all locations. Default is DE.
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
        # License
        [Parameter(Mandatory = $false)]
        [ValidateSet('SPE_E5', 'ENTERPRISEPREMIUM')]
        [string]
        $License = 'SPE_E5',
        
        # Usage location
        [Parameter(Mandatory = $false)]
        [string]
        $UsageLocation = 'DE'
    )

    $Cred = Get-Credential
    Connect-AzureAD -Credential $Cred

    $UserUPNList = (Get-AzureADUser).UserPrincipalName # Get UPN of every user
    
    foreach ($UserUPN in $UserUPNList) {  
        Set-UsageLocation -UserUPN $UserUPN -UsageLocation $UsageLocation # Assign usage location
        Remove-License -UserUPN $UserUPN # Remove currently assigned licenses from user account
        Set-License -UserUPN $UserUPN -License $License # Set specified license
    }

}