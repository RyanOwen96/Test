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
function Set-ListSiteColumns{
[cmdletBinding()]
    param(
         [Parameter()]  
         [String[]]$Groups,
         [Parameter(Mandatory=$True)]  
         $Lists,
         [Parameter()]
         [ValidateSet('BSS Number','Client Name','Subjects','Client')]
         $SiteFields
         )
        if($Groups -cnotcontains $null){
            foreach($Group in $Groups){
                Write-Host 'Connecting to' $Group -ForegroundColor Cyan
                Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/sites/'+$Group) -Credentials Sysadmin
                Write-Host 'Conneted to' $Group -ForegroundColor Green
                    foreach($list in $lists){
                        Write-Host $list 'List:'
                            foreach($SiteField in $SiteFields){
                                if(Get-PnPField -Group 'Fletchers'| Where-Object {$_.Title -eq $SiteField}){
                                        if(Get-PnPField -List $list | Where-Object {$_.Title -eq $SiteField}){
                                            Write-Host '-' $SiteField 'already in' $list
                                        }else{Add-PnPField -List $list -Field $SiteField
                                            Write-Host $SiteField 'added to' $list}
                                } else {Write-Host 'There is no site field with the name' $SiteField -ForegroundColor Red}
                            }

                    }
            }
        }
        if($Groups -eq $null){
            Write-Host 'No Group'
                foreach($list in $lists){
                    Write-Host $list 'List:'
                        foreach($SiteField in $SiteFields){
                            if(Get-PnPField -Group 'Fletchers'| Where-Object {$_.Title -eq $SiteField}){
                                if(Get-PnPField -List $list | Where-Object {$_.Title -eq $SiteField}){
                                    Write-Host '-' $SiteField 'already in' $list
                                }else{Add-PnPField -List $list -Field $SiteField
                                    Write-Host $SiteField 'added to' $list}
                    } else {Write-Host 'There is no site field with the name' $SiteField -ForegroundColor Red}
                }

        }

    }
}
