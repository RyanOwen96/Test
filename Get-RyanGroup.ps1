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
function Get-RyanGroup{
[cmdletBinding()]
    param(
         [Parameter(Mandatory=$True)]
         [string[]]$Url
         )
         Get-UnifiedGroup | Where-Object {$_.SharePointSiteUrl -eq 'https://sharepoint121.sharepoint.com/sites/'+ $Url}
}