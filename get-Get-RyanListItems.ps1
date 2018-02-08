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
function Get-RyanListItems{
[cmdletBinding()]
    param(
         [Parameter()]
         $List,
         $ID 
         )


         

         Write-Host '----------------------------------------'
         Write-Host 'Group:'$item['Title']
         write-host 'ID   :' $item['BSS']
         Write-Host 'Email:'$item['Email']
         Write-Host 'Site :' $item['Site']
                      

}