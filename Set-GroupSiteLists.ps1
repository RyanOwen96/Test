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
function Set-GroupSiteLists{
[cmdletBinding()]
    param(
         [Parameter(Mandatory=$True)]
         [string[]]$Groups,
         [Parameter(Mandatory=$True)]
         [ValidateSet('HR','H&S','Construction')]
         $Department,
         $Management = 'Management',
         $Employees ='Employees',
         $WorkActivities ='Work Activities',
         $WorkEquipment = 'Work Equipment',
         $Substances = 'Substances',
         $Workplaces = 'Workplaces'
         )
         
    foreach($Group in $Groups){
        $Web = get-pnpweb
        $W = $web.Url -replace 'https://sharepoint121.sharepoint.com/sites/',''
        $SavedGroup = Get-PnPUnifiedGroup | Where-Object{$_.Siteurl -eq 'https://sharepoint121.sharepoint.com/sites/'+$Group}
        if($W -cnotmatch $Group){
            Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/sites/'+ $group) -Credentials sysadmin
            Write-Host 'Now connected to' $SavedGroup.DisplayName
        }else{Write-Host 'Already connected to' $SavedGroup.DisplayName}
        $Contact1 = 'No'

            $GetContact = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Contact'}
            if($GetContact.EntityTypeName -eq 'Contact'){
                Write-Host 'Contact list has been found | Title: Contact' -ForegroundColor Gray
                Set-PnPList -Identity $GetContact.title -Title 'Contact' 
                $Contact1 = 'Yes'}

                if($Contact1 -eq 'No'){
                Write-Host 'Contact list has not been found' -ForegroundColor Red
                New-PnPList -Title 'Contact' -Template GenericList -Url 'Contact' -OnQuickLaunch
                Write-Host 'Contact list has now been made' -ForegroundColor Green}


##########################################################################################################################################################################
            if($Department -eq 'HR'){
                $Management1 = 'No'
                $Employees1 = 'No'
    #-------------------------------------------------------------------------------------------------------------#
                $GetManagement = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Management'}
                if($GetManagement.EntityTypeName -eq 'Management'){
                    Write-Host 'Management list has been found | Title:'$Management -ForegroundColor Gray
                    Set-PnPList -Identity $GetManagement.title -Title $Management
                    $Management1 = 'Yes'}
    
                    if($Management1 -eq 'No'){
                    Write-Host 'Management list has not been found' -ForegroundColor Red
                    New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch
                    Write-Host 'Management list has now been made' -ForegroundColor Green}
    
    #-------------------------------------------------------------------------------------------------------------#
                $GetEmployees = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Employees'}
                if($GetEmployees.EntityTypeName -eq 'Employees'){
                Write-Host 'Employees list has been found | Title:'$Employees -ForegroundColor Gray
                Set-PnPList -Identity $GetEmployees.title -Title $Employees
                $Employees1 = 'Yes'}
    
                    if($Employees1 -eq 'No'){
                    Write-Host 'Employees list has not been found' -ForegroundColor Red
                    New-PnPList -Title $Employees -Template GenericList -Url $Employees -OnQuickLaunch
                    Write-Host 'Employees list has now been made' -ForegroundColor Green}

            }
##########################################################################################################################################################################
            if($Department -eq 'H&S'){
                $Management1 = 'No'
                $WorkEquipment1 = 'No'
                $Substances1 = 'No'
                $Workplaces1 = 'No'
#-------------------------------------------------------------------------------------------------------------#
            $GetManagement = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Management'}
            if($GetManagement.EntityTypeName -eq 'Management'){
                Write-Host 'Management list has been found | Title:'$Management -ForegroundColor Gray
                Set-PnPList -Identity $GetManagement.title -Title $Management
                $Management1 = 'Yes'}

                if($Management1 -eq 'No'){
                Write-Host 'Management list has not been found' -ForegroundColor Red
                New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch
                Write-Host 'Management list has now been made' -ForegroundColor Green}

#-------------------------------------------------------------------------------------------------------------#
            $GetWorkEquipment = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Work_x0020_Equipment'}
            if($GetWorkEquipment.EntityTypeName -eq 'Work_x0020_Equipment'){
            Write-Host 'Work Equipment list has been found | Title:'$WorkEquipment -ForegroundColor Gray
            Set-PnPList -Identity $GetWorkEquipment.title -Title $WorkEquipment
            $WorkEquipment1 = 'Yes'}

                if($WorkEquipment1 -eq 'No'){
                Write-Host 'Work Equipment list has not been found' -ForegroundColor Red
                New-PnPList -Title $WorkEquipment -Template GenericList -Url $WorkEquipment -OnQuickLaunch
                Write-Host 'Work Equipment list has now been made' -ForegroundColor Green}
#-------------------------------------------------------------------------------------------------------------#
            $GetSubstances = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Substances'}
            if($GetSubstances.EntityTypeName -eq 'Substances'){
            Write-Host 'Substances list has been found | Title:'$Substances -ForegroundColor Gray
            Set-PnPList -Identity $GetSubstances.title -Title $Substances
            $Substances1 = 'Yes'}

                if($Substances1 -eq 'No'){
                Write-Host 'Substances list has not been found' -ForegroundColor Red
                New-PnPList -Title $Substances -Template GenericList -Url $Substances -OnQuickLaunch
                Write-Host 'Substances list has now been made' -ForegroundColor Green}
#-------------------------------------------------------------------------------------------------------------#
            $GetWorkplaces = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Workplaces'}
            if($GetWorkplaces.EntityTypeName -eq 'Workplaces'){
            Write-Host 'Workplaces list has been found | Title:'$Workplaces -ForegroundColor Gray
            Set-PnPList -Identity $GetWorkplaces.Title -Title $Workplaces
            $Workplaces1 = 'Yes'}

                if($Workplaces1 -eq 'No'){
                Write-Host 'Workplaces list has not been found' -ForegroundColor Red
                New-PnPList -Title $Workplaces -Template GenericList -Url $Workplaces -OnQuickLaunch
                Write-Host 'Workplaces list has now been made' -ForegroundColor Green}
#--------------------------------------------------------------------------------------------------------------#              
            }
##########################################################################################################################################################################
            if($Department -eq 'Construction'){
                $Management1 = 'No'
                $Workplaces1 = 'No'
#-------------------------------------------------------------------------------------------------------------#
            $GetManagement = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Management'}
            if($GetManagement.EntityTypeName -eq 'Management'){
                Write-Host 'Management list has been found | Title:'$Management -ForegroundColor Gray
                Set-PnPList -Identity $GetManagement.title -Title $Management
                $Management1 = 'Yes'}

                if($Management1 -eq 'No'){
                Write-Host 'Management list has not been found' -ForegroundColor Red
                New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch
                Write-Host 'Management list has now been made' -ForegroundColor Green}

#-------------------------------------------------------------------------------------------------------------#
            $GetWorkplaces = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Workplaces'}
            if($GetWorkplaces.EntityTypeName -eq 'Workplaces'){
            Write-Host 'Workplaces list has been found | Title:'$Workplaces -ForegroundColor Gray
            Set-PnPList -Identity $GetWorkplaces.Title -Title $Workplaces
            $Workplaces1 = 'Yes'}

                if($Workplaces1 -eq 'No'){
                Write-Host 'Workplaces list has not been found' -ForegroundColor Red
                New-PnPList -Title $Workplaces -Template GenericList -Url $Workplaces -OnQuickLaunch
                Write-Host 'Workplaces list has now been made' -ForegroundColor Green}
#--------------------------------------------------------------------------------------------------------------#  
##########################################################################################################################################################################


            }            
        }
   }




  