
Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/" -UseWebLogin

$items = Get-PnPListItem -List 'Main'
foreach($item in $items){

    Get-RyanListItems -List 'Main' -ID $item.Id

    If(Get-RyanGroup -Url $Item['BSS']){
        Write-Host 'Has a group' -ForegroundColor Cyan
        $Group = Get-RyanGroup -Url $Item['BSS']
        Set-GroupSiteLists -Groups $Group.DisplayName -Department $item['Department']
        Get-ContactListinformation -ListitemID '8' -GroupAlias 'Dev1' 

             
    } else {
    
            Write-Host 'Has no group' -ForegroundColor Red
            New-RyanGroups -DisplayName $item['Title'] -Alias $item['BSS'] -MakeGroup:$false
                }


        #site Columns
        Set-GroupSiteLists -Groups $Group.DisplayName 
        #lists columns
        #views

Disconnect-PnPOnline
       
}