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
         $Management,
         [Parameter()]  
         $Employees,
         [Parameter()]  
         $WorkActivities,
         [Parameter()]  
         $WorkEquipment,
         [Parameter()]  
         $Substances,
         [Parameter()]  
         $Workplaces
         )

        foreach($Group in $Groups){
            $Group = 'Dev1'
            $Connecting =" Connecting to site " + $Group
            Write-Host $Connecting -ForegroundColor Cyan
            $GetGroup = Get-PnPUnifiedGroup -Identity $Group
            $FoundGroup = "No"
            if(Get-PnPUnifiedGroup -Identity $Group){
                Connect-PnPOnline -Url ($GetGroup.SiteUrl) -Credentials Sysadmin
                $Text =" Connected to site " + $GetGroup.DisplayName 
                Write-Host $Text -ForegroundColor Green
                $FoundGroup = "Yes"}

                    foreach($list in $Lists){
                    Add-PnPField -List $list -Field 
            }

        }

    }



Get-PnPField -Group 'Fletchers' -Identity 'BSS Number'