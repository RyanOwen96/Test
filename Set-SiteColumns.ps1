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
            Connect-PnPOnline -Url ($GetGroup.SiteUrl) -Credentials Sysadmin}

        
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}){
            Write-Host $BSSNumber 'Site Column Found'
            $GetBSSNumber = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}
            Set-PnPField -Identity $GetBSSNumber.Title -Values @{'Title'=$BSSNumber} -UpdateExistingLists 
        }else{
            Write-Host $BSSNumber 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $BSSNumber -InternalName 'BSS Number' -Type Text -Group "Fletchers"
            Write-Host $BSSNumber 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client Name'}){
            Write-Host $ClientName 'Site Column Found'
            $GetClient = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client Name'}
            Set-PnPField -Identity $GetClient.Title -Values @{'Title'=$GetClient} -UpdateExistingLists 
        }else{
            Write-Host $ClientName 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $ClientName -InternalName 'Client Name' -Type Text -Group "Fletchers"
            Write-Host $ClientName 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Subjects'}){
            Write-Host $Subjects 'Site Column Found'
            $GetSubjects = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}
            Set-PnPField -Identity $GetSubjects.Title -Values @{'Title'=$Subjects} -UpdateExistingLists 
        }else{
            Write-Host $Subjects 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $Subjects -InternalName 'Subjects' -Type Text -Group "Fletchers"
            Write-Host $Subjects 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client'}){
            Write-Host $Client 'Site Column Found'
            $GetClient = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}
            Set-PnPField -Identity $GetClient.Title -Values @{'Title'=$Client} -UpdateExistingLists 
        }else{
            Write-Host $Client 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $Client -InternalName 'Client' -Type Text -Group "Fletchers"
            Write-Host $Client 'was created' -ForegroundColor Green}

}




