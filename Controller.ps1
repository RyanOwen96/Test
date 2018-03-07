Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/" -Credentials sysadmin
$items = Get-PnPListItem -List 'Main'
foreach($item in $items){
    Get-RyanListItems -List 'Main' -ID $item.Id
    If(Get-RyanGroup -Url $Item['BSS']){
        Write-Host 'Has a group' -ForegroundColor Cyan
        $Group = Get-RyanGroup -Url $Item['BSS']
        Set-GroupSiteLists -Groups $Group.DisplayName -Department $item['Department']
        Set-SiteColumns
        Set-ListSiteColumns -Lists 'Workplaces','Management'-SiteFields 'BSS Number','Subjects','Client Name','Client'
        Get-ContactListinformation -ListitemID $Item.Id 
 

        #setting the list to Group items / Email / Site
 
             
            } else {
    
            Write-Host 'Has no group' -ForegroundColor Red
            New-RyanGroups -DisplayName $item['Title'] -Alias $item['BSS'] -MakeGroup
           }
}

#Set-ListURl -List'' -Site'' 

Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/sites/dev1" -Credentials sysadmin 

