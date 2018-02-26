
Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/" -UseWebLogin

$items = Get-PnPListItem -List 'Main'
foreach($item in $items){

    Get-RyanListItems -List 'Main' -ID $item.Id

    If(Get-RyanGroup -Url $Item['BSS']){
        Write-Host 'Has a group' -ForegroundColor Cyan
        $Group = Get-RyanGroup -Url $Item['BSS']
        Set-GroupSiteLists -Groups $Group.DisplayName -Department $item['Department']

        #Set-SiteColumns -Site''
        #lists columns -Site ''

        Get-ContactListinformation -ListitemID $Item.Id


        #setting the list to Group items / Email / Site
 
             
            } else {
    
            Write-Host 'Has no group' -ForegroundColor Red
            New-RyanGroups -DisplayName $item['Title'] -Alias $item['BSS'] -MakeGroup:$false
           }


Disconnect-PnPOnline
       
}

#Set-ListURl -List'' -Site'' 
