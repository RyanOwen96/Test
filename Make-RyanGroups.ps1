  <#
.Synopsis
Connects to a site or sites to change or add views.
.Description
Connects to group site and check every list title and sees if there is a list.
if there is no list then the tool will make one with the correct name.
.Parameter $Groups
This allows the user to type in a group name or names. 
.Example
Set-GroupSiteLists -Groups 'Dev1'
#>
function Make-RyanGroups{
[cmdletBinding()]
    param(
         [Parameter(Mandatory=$True)]
         $DisplayName,
         [Parameter(Mandatory=$True)]
         $Alias,
         [Parameter(Mandatory=$True)]
         $EmailAddresses,
         [Parameter()]
         $Owner = 'Sysadmin@fletcher-dev.co.uk'
         )

    Write-Host 'creating group' $DisplayName -ForegroundColor Cyan 
    New-UnifiedGroup -DisplayName $DisplayName -Alias $Alias -Language (Get-Culture) -EmailAddresses $EmailAddresses -Owner $Owner
    Write-Host $DisplayName 'group was made' -ForegroundColor Green 
      
 }