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
            $Web = get-pnpweb 
            Write-Host 'Getting' $web.Title 'contact information' -ForegroundColor Green }

        if($GroupAlias -cnotcontains $null){
            Write-Host 'Connecting to' $GroupAlias -ForegroundColor Green
            Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/Sites/'+ $GroupAlias) -UseWebLogin
         }
         
        $Contacts = Get-PnPListItem -List 'Contact'
        Connect-PnPOnline -Url 'https://sharepoint121.sharepoint.com/' -UseWebLogin
        foreach($Contact in $Contacts){

            if($contact['Postcode'] -cnotcontains $null){Write-Host 'Postcode:'$Contact['Postcode']}
            if($contact['Postcode'] -eq $null){write-host 'Postcode = N/A' 
            $contact['Postcode'] = 'N/A'}

            if($contact['City'] -cnotcontains $null){Write-Host 'City:'$Contact['City']}
            if($contact['City'] -eq $null){Write-Host 'City = N/A'
            $contact['City'] = 'N/A'}

            if($contact['Phone'] -cnotcontains $null){Write-Host 'Phone:'$Contact['Phone']}
            if($contact['Phone'] -eq $null){Write-Host 'Phone = N/A'
            $contact['Phone'] = 'N/A'}

            Set-PnPListItem -List 'Main' -Identity $ListitemID -Values @{'Postcode'= $Contact['Postcode'];'Phone'=$Contact['Phone'];'City'=$Contact['City']} | Format-Table -HideTableHeaders
        }

}


