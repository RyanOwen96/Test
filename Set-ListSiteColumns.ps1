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
         [Parameter(Mandatory=$True)]  
         $Groups,
         [Parameter(Mandatory=$True)]  
         $Lists,
         [Parameter()]
         [ValidateSet('BSS Number','Client Name','Subjects','Client')]
         $SiteFields
         )

        foreach($Group in $Groups){
            $Connecting =" Connecting to site " + $Group
            $GetGroup = Get-PnPUnifiedGroup -Identity $Group
            $Groups = Get-PnPUnifiedGroup
            if($Group -cnotmatch $Groups){
                Write-Host $Connecting -ForegroundColor Cyan
                Connect-PnPOnline -Url ($GetGroup.SiteUrl) -Credentials Sysadmin
                $Text =" Connected to site " + $GetGroup.DisplayName 
                Write-Host $Text -ForegroundColor Green
                
                    foreach($list in $lists){

                            foreach($SiteField in $SiteFields){
                                
                                if(Get-PnPField -Group 'Fletchers'| Where-Object {$_.Title -eq $SiteField}){
                                        Write-Host $SiteField 'Found field' -ForegroundColor Magenta
                                        if(Get-PnPField -List $list -Identity $SiteField){
                                            Write-Host $SiteField 'Already in' $list
                                        }else{
                                            Add-PnPField -List $list -Field $SiteField
                                            Write-Host $SiteField 'added to' $list     
                                        }
 
                                }else{Write-Host 'There is no site field with the name' $SiteField}
                            }

                    }
                }else{Write-Host 'No group found'}
    }
}
