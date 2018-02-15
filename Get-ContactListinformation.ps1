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
function Get-ContactListinformation{
[cmdletBinding()]
    param(
         [Parameter(Mandatory=$True)]  
         $ListitemID,
         [Parameter()]  
         $GroupAlias
         )
        

        if($GroupAlias -eq $null){
            Write-Host 'Not Connect'
         write-host 'Null'}

        if($GroupAlias -cnotcontains $null){
            Write-Host 'Connect'
            Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/Sites/'+ $GroupAlias) -UseWebLogin
         }
        
        $Contacts = Get-PnPListItem -List 'Contact'
        Connect-PnPOnline -Url 'https://sharepoint121.sharepoint.com/' -UseWebLogin
        foreach($Contact in $Contacts){
            Write-Host $Contact['Postcode']
            Set-PnPListItem -List 'Main' -Identity $ListitemID -Values @{'Postcode'= $Contact['Postcode'];'Phone'=$Contact['Phone'];'City'=$Contact['City']}
        }

}


