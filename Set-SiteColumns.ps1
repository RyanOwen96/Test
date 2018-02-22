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
function Set-SiteColumns{
[cmdletBinding()]
    param(
         [Parameter(Mandatory=$True)]
         $Group,
         [Parameter()]
         $BSSNumber = "BSS Number",
         [Parameter()]
         $ClientName = "Client Name",
         [Parameter()]
         $Subjects = "Subjects",
         [Parameter()]
         $Client = "Client"
         )
        #if not connected to the site it will connect
         $GetGroup = Get-PnPUnifiedGroup -Identity $Group
         $Web = Get-PnPWeb
            if($GetGroup.SiteUrl -eq $Web.Url){
                 Write-Host 'Match'
            } else {Write-Host 'Dont Match'
            Connect-PnPOnline -Url ($GetGroup.SiteUrl) -UseWebLogin}

        
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}){
            Write-Host 'Site Column Found'
        }else{
            Write-Host 'Site Column cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName 'BSS Number' -InternalName 'BSS Number' -Type Text -Group "Fletchers"
            Write-Host 'BSS Number was created' -ForegroundColor Green
        }

}




