function Set-UsageLocation {
    <#
    .SYNOPSIS
        Assign usage location for user account.
    .DESCRIPTION
        Before a license can be assigned to a user, the administrator has to specify the usage location property on the user. 
        Some Microsoft services are not available in all locations.
    .PARAMETER UserUPN
        Specifies the ID (as UPN) of a user in Azure AD.
    .PARAMETER UsageLocation
        ISO 3166-1 alpha-2 country code.
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

        # Usage location
        [Parameter(Mandatory)]
        [string]
        $UsageLocation
    )

    Set-AzureADUser -ObjectID $UserUPN -UsageLocation $UsageLocation
}