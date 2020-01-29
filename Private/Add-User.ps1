function Add-User {
    <#
    .SYNOPSIS
        Creates user accounts in Azure Active Directory.
    .DESCRIPTION
        Creates user accounts in Azure Active Directory.
    .PARAMETER UserCount
        The number of user accounts to create.
    .PARAMETER OrgName
        The name of the organization.
    .PARAMETER UsageLocation
        ISO 3166-1 alpha-2 country code.
        Before a license can be assigned to a user, the administrator has to specify the usage location property on the user. 
        Some Microsoft services are not available in all locations.
    .EXAMPLE
        PS C:\> Add-User -UserCount 5 -OrgName Contoso -UsageLocation DE
        Creates 5 users in DE for the Contoso organization.
    .INPUTS
        None. You cannot pipe objects to Add-User.
    .OUTPUTS
        None. Add-User does not generate any output.
    .NOTES
        The use of a common password here is for automation and ease of configuration for a test environment.
        Obviously, this is highly discouraged for production subscriptions.
    #>
    [CmdletBinding()]
    param (
        # The number of users to create
        [Parameter(Mandatory)]
        [int]
        $UserCount,
        
        # The name of the organization 
        [Parameter(Mandatory)]
        [string]
        $OrgName,

        # Usage location
        [Parameter(Mandatory)]
        [string]
        $UsageLocation
    )

    # Common user password profile
    $CommonPwd = "AweS0me@PW" 
    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = $CommonPwd
    $PasswordProfile.EnforceChangePasswordPolicy = $false
    $PasswordProfile.ForceChangePasswordNextLogin = $false
    
    # Create object containing random first and last name combinations
    $ObjNames = Invoke-RandomUserName -UserCount $UserCount

    # Create users
    for ($i = 0; $i -lt $UserCount; $i++) {
        $UserUPN = "$($ObjNames[$i].FirstName)$($ObjNames[$i].SurName)@" + $OrgName + ".onmicrosoft.com"

        $NewAzureADUserSplat = @{
            DisplayName       = "$($ObjNames[$i].FirstName) $($ObjNames[$i].SurName)"
            GivenName         = $ObjNames[$i].FirstName
            SurName           = $ObjNames[$i].SurName
            UserPrincipalName = $UserUPN
            UsageLocation     = $UsageLocation
            AccountEnabled    = $true
            PasswordProfile   = $PasswordProfile
            MailNickName      = "$($ObjNames[$i].FirstName)$($ObjNames[$i].SurName)"
        }
        New-AzureADUser @NewAzureADUserSplat
    }
}