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
         [Parameter()]
         [string[]]$Groups,
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
if($Groups -cnotcontains $null){
    Write-Host 'There a group' -ForegroundColor Green
    foreach($Group in $Groups){
        $Web = get-pnpweb
        $W = $web.Url -replace 'https://sharepoint121.sharepoint.com/sites/',''
        $SavedGroup = Get-PnPUnifiedGroup | Where-Object{$_.Siteurl -eq 'https://sharepoint121.sharepoint.com/sites/'+$Group}
        if($W -cnotmatch $Group){
            Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/sites/'+ $group) -Credentials sysadmin
            Write-Host 'Now connected to' $SavedGroup.DisplayName
        }else{Write-Host 'Already connected to' $SavedGroup.DisplayName}
#------------------------------------------------------------------------------------------------------------------------------        
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}){
            Write-Host $BSSNumber 'Site Column Found'
            $GetBSSNumber = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}
            Set-PnPField -Identity $GetBSSNumber.Id -Values @{"Title"=$BSSNumber} -UpdateExistingLists 
            
        }else{
            Write-Host $BSSNumber 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $BSSNumber -InternalName 'BSS Number' -Type Text -Group "Fletchers"
            Write-Host $BSSNumber 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client Name'}){
            Write-Host $ClientName 'Site Column Found'
            $GetClient = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client Name'}
            Set-PnPField -Identity $GetClient.Id -Values @{'Title'=$ClientName} -UpdateExistingLists 
        }else{
            Write-Host $ClientName 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $ClientName -InternalName 'Client Name' -Type Text -Group "Fletchers"
            Write-Host $ClientName 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Subjects'}){
            Write-Host $Subjects 'Site Column Found'
            $GetSubjects = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Subjects'}
            Set-PnPField -Identity $GetSubjects.Id -Values @{'Title'=$Subjects} -UpdateExistingLists 
        }else{
            Write-Host $Subjects 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $Subjects -InternalName 'Subjects' -Type Text -Group "Fletchers"
            Write-Host $Subjects 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
        if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client'}){
            Write-Host $Client 'Site Column Found'
            $GetClient = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client'}
            Set-PnPField -Identity $GetClient.Id -Values @{'Title'=$Client} -UpdateExistingLists 
        }else{
            Write-Host $Client 'cannot be found' -ForegroundColor Red
            Add-PnPField -DisplayName $Client -InternalName 'Client' -Type Text -Group "Fletchers"
            Write-Host $Client 'was created' -ForegroundColor Green}
        }
    }


if($Groups -eq $null){
    Write-Host 'There no group' -ForegroundColor Magenta
#------------------------------------------------------------------------------------------------------------------------------        
    if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}){
        Write-Host $BSSNumber 'Site Column Found'
        $GetBSSNumber = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'BSS Number'}
        Set-PnPField -Identity $GetBSSNumber.Id -Values @{"Title"=$BSSNumber} -UpdateExistingLists 
        
    }else{
        Write-Host $BSSNumber 'cannot be found' -ForegroundColor Red
        Add-PnPField -DisplayName $BSSNumber -InternalName 'BSS Number' -Type Text -Group "Fletchers"
        Write-Host $BSSNumber 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
    if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client Name'}){
        Write-Host $ClientName 'Site Column Found'
        $GetClient = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client Name'}
        Set-PnPField -Identity $GetClient.Id -Values @{'Title'=$ClientName} -UpdateExistingLists 
    }else{
        Write-Host $ClientName 'cannot be found' -ForegroundColor Red
        Add-PnPField -DisplayName $ClientName -InternalName 'Client Name' -Type Text -Group "Fletchers"
        Write-Host $ClientName 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
    if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Subjects'}){
        Write-Host $Subjects 'Site Column Found'
        $GetSubjects = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Subjects'}
        Set-PnPField -Identity $GetSubjects.Id -Values @{'Title'=$Subjects} -UpdateExistingLists 
    }else{
        Write-Host $Subjects 'cannot be found' -ForegroundColor Red
        Add-PnPField -DisplayName $Subjects -InternalName 'Subjects' -Type Text -Group "Fletchers"
        Write-Host $Subjects 'was created' -ForegroundColor Green}
#------------------------------------------------------------------------------------------------------------------------------
    if(Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client'}){
        Write-Host $Client 'Site Column Found'
        $GetClient = Get-PnPField -Group 'Fletchers' | Where-Object {$_.InternalName -eq 'Client'}
        Set-PnPField -Identity $GetClient.Id -Values @{'Title'=$Client} -UpdateExistingLists 
    }else{
        Write-Host $Client 'cannot be found' -ForegroundColor Red
        Add-PnPField -DisplayName $Client -InternalName 'Client' -Type Text -Group "Fletchers"
        Write-Host $Client 'was created' -ForegroundColor Green}

  }

}
