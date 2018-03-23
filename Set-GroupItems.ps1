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
function Set-GroupItems{
    [cmdletBinding()]
        param(
            [Parameter(Mandatory=$True)]  
            $SiteUrl,
            [Parameter(Mandatory=$True)]  
            $list,
            [Parameter(Mandatory=$True)]  
            $ListItemId,
            [Parameter(Mandatory=$True)]  
            $Group,
            [Parameter()]  
            [Switch]$Site,
            [Parameter()]  
            [Switch]$Email
        )


    $items = Get-PnPListItem -List $list -Id $ListItemId
    foreach($item in $items){
        connect-pnponline -Url $SiteUrl -Credentials sysadmin 
        $Groupsave = Get-pnpUnifiedGroup -Identity $Group
        $G = $Groupsave.SiteUrl + ', Link'
        if($site.IsPresent){Set-PnPListItem -List $list -Identity $ListItemId -Values @{'Site'= $G}}
        if($Email.IsPresent){Set-PnPListItem -List $list -Identity $ListItemId -Values @{'Email'= $Groupsave.Mail}}
    }
}



