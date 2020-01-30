function Start-OneDriveProvisioning {
    <#
    .SYNOPSIS
        Pre-provision OneDrive for users in your organization.
    .DESCRIPTION
        By default, the first time that a user browses to their OneDrive it's automatically provisioned for them. 
        But in some cases you might want your users' OneDrive locations to be pre-provisioned.
        This can be achieved using a PowerShell cmdlet provided as part of the SharePoint Online Management Shell.
    .PARAMETER Cred
        PSCredential object that represents the global administrator credentials.
    .PARAMETER OrgName
        The name of the organization.
    .PARAMETER UserUPNList
        Specifies one or more user logins to be enqueued for the creation of a Personal Site. 
        You can specify between 1 and 200 users.
    .EXAMPLE
        PS C:\> Start-OneDriveProvisioning -Cred $Cred -OrgName Contoso -UserUPNList $UserUPNList
        Explanation of what the example does
    .INPUTS
        None. You cannot pipe objects to Start-OneDriveProvisioning.
    .OUTPUTS
        None. Start-OneDriveProvisioning does not generate any output.
    .NOTES
        If you are pre-provisioning OneDrive for many users, it might take up to 24 hours for the OneDrive locations to be created. 
    #>
    [CmdletBinding()]
    param (
        # Credential object
        [Parameter(Mandatory)]
        #[ValidateNotNull]
        [System.Management.Automation.PSCredential] 
        $Cred,

        # The name of the organization 
        [Parameter(Mandatory)]
        [string]
        $OrgName,

        # Array holding the UPN list
        [Parameter(Mandatory)]
        [array]
        $UserUPNList
    )
    
    Connect-SPOService -Url https://$OrgName-admin.sharepoint.com -Credential $Cred

    Request-SPOPersonalSite -UserEmails $UserUPNList
}