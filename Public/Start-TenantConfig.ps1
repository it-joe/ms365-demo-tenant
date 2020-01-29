function Start-TenantConfig {
    <#
    .SYNOPSIS
        Configures an existing tenant for demo purposes.
    .DESCRIPTION
        Configures an existing tenant for demo purposes. 
        Includes rich, demo-ready sample content (document libraries, emails, OneDrive contents, Yammer posts, etc.).
    .PARAMETER License
        Select the licensing plan for your tenant. 
        After creating your Office 365 E5 and Microsoft 365 E5 trial subscription you would be able choose between SPE_E5 and ENTERPRISEPREMIUM. 
        Default is SPE_E5 as it includes the ENTERPRISEPREMIUM license plan.
    .PARAMETER UsageLocation
        ISO 3166-1 alpha-2 country code.
        Before a license can be assigned to a user, the administrator has to specify the usage location property on the user. 
        Some Microsoft services are not available in all locations. Default is DE.
    .PARAMETER UserCount
        The number of user accounts to create.
        The value of this parameter must be between 1 and 25 as the Microsoft 365 E5 trail subscription includes up to 25 licenses. 
        To ensure that every user can be assigned a license, said limit should not be exceeded. Default is 25.
    .EXAMPLE
        PS C:\> Start-TenantConfig -UserCount 10
        Initiates the demo tenant configuration and creates 10 users with Microsoft 365 E5 licenses assigned and a usage location property of DE.
    .INPUTS
        None. You cannot pipe objects to Start-TenantConfig.
    .OUTPUTS
        None. Start-TenantConfig does not generate any output.
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
        $UsageLocation = 'DE',

        # The number of users to create
        [Parameter(Mandatory = $false)]
        [ValidateRange(1,25)]
        [int]
        $UserCount = '25'
    )
    
    <# $Cred = Get-Credential
    Connect-AzureAD -Credential $Cred #>
    
    #region Gather tenant details for later processing
    $OrgName = (Get-AzureADTenantDetail).DisplayName # The name of the organization
    #Endregion

    # Create user accounts
    Add-User -UserCount $UserCount -OrgName $OrgName -UsageLocation $UsageLocation

    # Assign licenses
    $UserUPNList = (Get-AzureADUser).UserPrincipalName # Get UPN of every user
    
    foreach ($UserUPN in $UserUPNList) {  
        Set-UsageLocation -UserUPN $UserUPN -UsageLocation $UsageLocation # Assign usage location
        Remove-License -UserUPN $UserUPN # Remove currently assigned licenses from user account
        Set-License -UserUPN $UserUPN -License $License # Set specified license
    }

}