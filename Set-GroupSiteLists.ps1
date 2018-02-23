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
         [string]$Management = 'Management',
         [string]$Employees ='Employees',
         [string]$WorkActivities ='Work Activities',
         [string]$WorkEquipment = 'Work Equipment',
         [string]$Substances = 'Substances',
         [string]$Workplaces = 'Workplaces'
         )

    foreach($Group in $Groups){

        $Connecting =" Connecting to site " + $Group
        Write-Host $Connecting -ForegroundColor Cyan
        $GetGroup = Get-PnPUnifiedGroup -Identity $Group
        $FoundGroup = "No"

        if(Get-PnPUnifiedGroup -Identity $Group){
            Connect-PnPOnline -Url ($GetGroup.SiteUrl) -UseWebLogin
            $Text =" Connected to site " + $GetGroup.DisplayName 
            Write-Host $Text -ForegroundColor Green
            $FoundGroup = "Yes"

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
                    Set-PnPList -Identity $GetManagement -Title $Management
                    $Management1 = 'Yes'}
    
                    if($Management1 -eq 'No'){
                    Write-Host 'Management list has not been found' -ForegroundColor Red
                    New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch
                    Write-Host 'Management list has now been made' -ForegroundColor Green}
    
    #-------------------------------------------------------------------------------------------------------------#
                $GetEmployees = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Employees'}
                if($GetEmployees.EntityTypeName -eq 'Employees'){
                Write-Host 'Employees list has been found | Title:'$Employees -ForegroundColor Gray
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
                Set-PnPList -Identity $GetManagement -Title $Management
                $Management1 = 'Yes'}

                if($Management1 -eq 'No'){
                Write-Host 'Management list has not been found' -ForegroundColor Red
                New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch
                Write-Host 'Management list has now been made' -ForegroundColor Green}

#-------------------------------------------------------------------------------------------------------------#
            $GetWorkEquipment = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Work_x0020_Equipment'}
            if($GetWorkEquipment.EntityTypeName -eq 'Work_x0020_Equipment'){
            Write-Host 'Work Equipment list has been found | Title:'$WorkEquipment -ForegroundColor Gray
            $WorkEquipment1 = 'Yes'}

                if($WorkEquipment1 -eq 'No'){
                Write-Host 'Work Equipment list has not been found' -ForegroundColor Red
                New-PnPList -Title $WorkEquipment -Template GenericList -Url $WorkEquipment -OnQuickLaunch
                Write-Host 'Work Equipment list has now been made' -ForegroundColor Green}
#-------------------------------------------------------------------------------------------------------------#
            $GetSubstances = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Substances'}
            if($GetSubstances.EntityTypeName -eq 'Substances'){
            Write-Host 'Substances list has been found | Title:'$Substances -ForegroundColor Gray
            $Substances1 = 'Yes'}

                if($Substances1 -eq 'No'){
                Write-Host 'Substances list has not been found' -ForegroundColor Red
                New-PnPList -Title $Substances -Template GenericList -Url $Substances -OnQuickLaunch
                Write-Host 'Substances list has now been made' -ForegroundColor Green}
#-------------------------------------------------------------------------------------------------------------#
            $GetWorkplaces = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Workplaces'}
            if($GetWorkplaces.EntityTypeName -eq 'Workplaces'){
            Write-Host 'Workplaces list has been found | Title:'$Workplaces -ForegroundColor Gray
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
                Set-PnPList -Identity $GetManagement -Title $Management
                $Management1 = 'Yes'}

                if($Management1 -eq 'No'){
                Write-Host 'Management list has not been found' -ForegroundColor Red
                New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch
                Write-Host 'Management list has now been made' -ForegroundColor Green}

#-------------------------------------------------------------------------------------------------------------#
            $GetWorkplaces = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Workplaces'}
            if($GetWorkplaces.EntityTypeName -eq 'Workplaces'){
            Write-Host 'Workplaces list has been found | Title:'$Workplaces -ForegroundColor Gray
            $Workplaces1 = 'Yes'}

                if($Workplaces1 -eq 'No'){
                Write-Host 'Workplaces list has not been found' -ForegroundColor Red
                New-PnPList -Title $Workplaces -Template GenericList -Url $Workplaces -OnQuickLaunch
                Write-Host 'Workplaces list has now been made' -ForegroundColor Green}
#--------------------------------------------------------------------------------------------------------------#  
##########################################################################################################################################################################


            }            
        }#End of if

        if($FoundGroup -eq "No"){Write-Host $GroupName 'Group Not Found' -ForegroundColor Red}

     }#end of group foreach
}#end param