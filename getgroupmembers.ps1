<#
.SYNOPSIS
Retrieves and displays the members of the specified Active Directory group.

.PARAMETER GroupName
The name of the Active Directory group.

.OUTPUTS
List of group members.

.EXAMPLE
    .\getitmembers.ps1 -groupName "Group Name"
    # Retrieves and displays the members of the specified Active Directory group.
#>

param (
    [string]$groupName
)

Import-Module ActiveDirectory

$groupMembers = Get-ADGroupMember -Identity $groupName

Write-Host $groupName "`n" $groupMembers.Count "members found" "`n"

foreach ($member in $groupMembers) {
    #Get-ADGroupMember returns a list of ADPrincipals, so we need to get the ADUser object for each member to get the DisplayName
    $user = Get-ADUser -Identity $member.SamAccountName -Properties DisplayName
    $memberSamAccountName = $user.SamAccountName
    $memberDisplayName = $user.DisplayName

    Write-Host $memberSamAccountName $memberDisplayName
}