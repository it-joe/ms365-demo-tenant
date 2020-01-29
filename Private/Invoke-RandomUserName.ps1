function Invoke-RandomUserName {
    <#
    .SYNOPSIS
        Creates and returns an object containing random first and last name combinations.
    .DESCRIPTION
        Creates and returns an object containing random first and last name combinations.
        The object consists of the FirstName and SurName property, which contain the specified number 
        of random name values.
    .PARAMETER UserCount
        The number of random data sets to create.
    .EXAMPLE
        PS C:\> Invoke-RandomUserName -UserCount 25
        Returns an object containing random values for the FirstName and SurName properties.
    .INPUTS
        None. You cannot pipe objects to Invoke-RandomUserName.
    .OUTPUTS
        None. Invoke-RandomUserName does not generate any output.
    #>
    [CmdletBinding()]
    param (
        # The number of random data sets to create
        [Parameter(Mandatory)]
        [int]
        $UserCount        
    )
    
    $ObjNames = @()
    
    # Start generating...
    1..$UserCount | ForEach-Object {

        $Male = Get-Random 2 # Flip a coin for gender
        
        # Pick a first name based on the gender
        if ($Male) {
            $FirstName = Get-Content "$PSScriptRoot\Males.txt" | Get-Random 
        }
        else { 
            $FirstName = Get-Content "$PSScriptRoot\Females.txt" | Get-Random 
        }
    
        $SurName = Get-Content "$PSScriptRoot\Surnames.txt" | Get-Random # Pick a surname

        # Create object to save names
        $ObjNames += [PSCustomObject]@{
            FirstName = $FirstName
            SurName   = $SurName
        }
    }
    return $ObjNames
}