Connect-PnPOnline -Url 'https://sharepoint121.sharepoint.com/' -Credentials sysadmin
$items = Get-PnPListItem -List 'Main'
foreach($item in $items){
    Get-RyanListItems -List 'Main' -ID $item.Id
    If(Get-RyanGroup -Url $Item['BSS']){
        Write-Host 'Has a group' -ForegroundColor Cyan
        $Group = Get-RyanGroup -Url $Item['BSS']
        Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/Sites/'+$Item['BSS']) -Credentials sysadmin
        Set-SiteColumns
        Set-GroupSiteLists -Groups $Group.DisplayName -Department $item['Department']
        Set-ListSiteColumns -Lists 'Workplaces','Management'-SiteFields 'BSS Number','Subjects','Client Name','Client'
        Get-ContactListinformation -ListitemID $Item.Id 
        Connect-PnPOnline -Url 'https://sharepoint121.sharepoint.com/' -Credentials sysadmin
        $Web = get-pnpweb
        Set-GroupItems -SiteUrl $Web.Url -list 'Main' -ListItemId $item.Id -Group $item['Title'] -Email -Site   
    } else {    
        Write-Host 'Has no group' -ForegroundColor Red
        New-RyanGroups -DisplayName $item['Title'] -Alias $item['BSS'] -EmailAddresses $item['FriendlyName'] -MakeGroup
    }
}

    Get-RyanConnection
    Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/sites/Dev1" -Credentials sysadmin
