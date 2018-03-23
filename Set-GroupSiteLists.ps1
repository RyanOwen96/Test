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
         [String[]]$Departments,
         $Management = 'Management',
         $Employees ='Employees',
         $WorkActivities ='Work Activities',
         $WorkEquipment = 'Work Equipment',
         $Substances = 'Substances',
         $Workplaces = 'Workplaces'
         )
         
    if($Groups -cnotcontains $null){
        foreach($Group in $Groups){
            $Web = get-pnpweb
            $W = $web.Url -replace 'https://sharepoint121.sharepoint.com/sites/',''
                if($W -cnotmatch $Group){
                    Connect-PnPOnline -Url ('https://sharepoint121.sharepoint.com/sites/'+ $group) -Credentials sysadmin
                    Write-Host 'Now connected to' $Group
                }
                foreach($Department in $Departments){
                    if($Department -eq 'HR'){
                        write-host 'HR'
                        $Management1 ='Yes'
                        $Employees1 ='Yes'
                        $WorkActivities1 ='No'
                        $WorkEquipment1 = 'No'
                        $Substances1 = 'No'
                        $Workplaces1 = 'No'
                    }
                    if($Department -eq 'H&S'){
                        Write-Host 'H&S'
                        $Management1 ='Yes'
                        $Employees1 ='No'
                        $WorkActivities1 ='No'
                        $WorkEquipment1 = 'No'
                        $Substances1 = 'Yes'
                        $Workplaces1 = 'Yes'
                    }
                    if($Department -eq 'Construction'){
                        Write-Host 'Construction'
                        $Management1 ='Yes'
                        $Employees1 ='No'
                        $WorkActivities1 ='No'
                        $WorkEquipment1 = 'No'
                        $Substances1 = 'No'
                        $Workplaces1 = 'Yes'
                    }
                    #Contact
                    $GetContact = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Contact'}
                    if($GetContact.EntityTypeName -eq 'Contact'){
                        if($GetContact.title -eq 'Contact'){
                            Write-Host 'Contact list has been found | Title: Contact' -ForegroundColor Gray
                        }else{
                            write-host 'Title was' $GetContact.Title 'now Contact' -ForegroundColor Red
                            Set-PnPList -Identity $GetContact.title -Title 'Contact'
                        }
                    }else{
                        Write-Host 'Contact list has not been found' -ForegroundColor Red
                        New-PnPList -Title 'Contact' -Template GenericList -Url 'Contact' -OnQuickLaunch
                        Write-Host 'Contact list has now been made' -ForegroundColor Green
                    }

                    if(Get-PnPField -List 'Contact'|Where-Object{$_.InternalName -eq 'Postcode'}){
                        }else{ 
                            Write-Host 'Postcode field could not be found' -ForegroundColor Red
                            Add-PnPField -List 'Contact' -DisplayName 'Postcode' -InternalName 'Postcode' -Type Text -AddToDefaultView
                            Write-Host 'Postcode field now added' -ForegroundColor Green
                        }

                    if(Get-PnPField -List 'Contact'|Where-Object{$_.InternalName -eq 'Phone'}){
                        }else{
                            Write-Host 'Phone field could not be found' -ForegroundColor Red
                            Add-PnPField -List 'Contact' -DisplayName 'Phone' -InternalName 'Phone' -Type Text -AddToDefaultView
                            Write-Host 'Phone field now added' -ForegroundColor Green
                        }

                    if(Get-PnPField -List 'Contact'|Where-Object{$_.InternalName -eq 'City'}){
                        }else{
                            Write-Host 'City field could not be found' -ForegroundColor Red
                            Add-PnPField -List 'Contact' -DisplayName 'City' -InternalName 'City' -Type Text -AddToDefaultView
                            Write-Host 'City field now added' -ForegroundColor Green
                        }


                    #Management
                    if($Management1 -eq 'Yes'){
                        $GetManagement = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Management'}
                        if($GetManagement.EntityTypeName -eq 'Management'){
                                if($GetManagement.title -eq $Management){
                                    Write-Host $Management 'list has been found | Title:'$Management -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetManagement.Title 'now' $Management -ForegroundColor Red
                                    Set-PnPList -Identity $GetManagement.title -Title $Management
                                }
                        }else{
                            Write-Host 'The list' $Management 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch 
                            Write-Host $Management 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #Employees
                    if($Employees1 -eq 'Yes'){
                        $GetEmployees = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Employees'}
                        if($GetEmployees.EntityTypeName -eq 'Employees'){
                                if($GetEmployees.title -eq $Employees){
                                    Write-Host $Employees 'list has been found | Title:'$Employees -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetEmployees.Title 'now' $Employees -ForegroundColor Red
                                    Set-PnPList -Identity $GetEmployees.title -Title $Employees
                                }
                        }else{
                            Write-Host 'The list' $Employees 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Employees -Template GenericList -Url $Employees -OnQuickLaunch 
                            Write-Host $Employees 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #WorkActivities1
                    if($WorkActivities1 -eq 'Yes'){
                        $GetWorkActivities = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'WorkActivities'}
                        if($GetWorkActivities.EntityTypeName -eq 'WorkActivities'){
                                if($GetWorkActivities.title -eq $WorkActivities){
                                    Write-Host $WorkActivities 'list has been found | Title:'$WorkActivities -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetWorkActivities.Title 'now' $WorkActivities -ForegroundColor Red
                                    Set-PnPList -Identity $GetWorkActivities.title -Title $WorkActivities
                                }
                        }else{
                            Write-Host 'The list' $WorkActivities 'was not found' -ForegroundColor Red
                            New-PnPList -Title $WorkActivities -Template GenericList -Url $WorkActivities -OnQuickLaunch 
                            Write-Host $WorkActivities 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #Substances1
                    if($Substances1 -eq 'Yes'){
                        $GetSubstances = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Substances'}
                        if($GetSubstances.EntityTypeName -eq 'Substances'){
                                if($GetSubstances.title -eq $Substances){
                                    Write-Host $Substances 'list has been found | Title:'$Substances -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetSubstances.Title 'now' $Substances -ForegroundColor Red
                                    Set-PnPList -Identity $getSubstances.title -Title $Substances
                                }
                        }else{
                            Write-Host 'The list' $Substances 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Substances -Template GenericList -Url $Substances -OnQuickLaunch 
                            Write-Host $Substances 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #Workplaces1
                    if($Workplaces1 -eq 'Yes'){
                        $GetWorkplaces = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Workplaces'}
                        if($GetWorkplaces.EntityTypeName -eq 'Workplaces'){
                                if($GetWorkplaces.title -eq $Workplaces){
                                    Write-Host $Workplaces 'list has been found | Title:'$Workplaces -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetWorkplaces.Title 'now' $Workplaces -ForegroundColor Red
                                    Set-PnPList -Identity $getWorkplaces.title -Title $Workplaces
                                }
                        }else{
                            Write-Host 'The list' $Workplaces 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Workplaces -Template GenericList -Url $Workplaces -OnQuickLaunch 
                            Write-Host $Workplaces 'list has now been made' -ForegroundColor Green
                        }
                    }

                }#Foreach Department
            }#Foreach Group
        }#Group $null
    if($Groups -eq $null){
        foreach($Department in $Departments){
            if($Department -eq 'HR'){
                write-host 'HR'
                $Management1 ='Yes'
                $Employees1 ='Yes'
                $WorkActivities1 ='No'
                $WorkEquipment1 = 'No'
                $Substances1 = 'No'
                $Workplaces1 = 'No'
            }
            if($Department -eq 'H&S'){
                Write-Host 'H&S'
                $Management1 ='Yes'
                $Employees1 ='No'
                $WorkActivities1 ='No'
                $WorkEquipment1 = 'No'
                $Substances1 = 'Yes'
                $Workplaces1 = 'Yes'
            }
            if($Department -eq 'Construction'){
                Write-Host 'Construction'
                $Management1 ='Yes'
                $Employees1 ='No'
                $WorkActivities1 ='No'
                $WorkEquipment1 = 'No'
                $Substances1 = 'No'
                $Workplaces1 = 'Yes'
            }
                    #Contact
                    $GetContact = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Contact'}
                    if($GetContact.EntityTypeName -eq 'Contact'){
                        if($GetContact.title -eq 'Contact'){
                            Write-Host 'Contact list has been found | Title: Contact' -ForegroundColor Gray
                        }else{
                            write-host 'Title was' $GetContact.Title 'now Contact' -ForegroundColor Red
                            Set-PnPList -Identity $GetContact.title -Title 'Contact' 
                            
                        }
                    }else{
                        Write-Host 'Contact list has not been found' -ForegroundColor Red
                        New-PnPList -Title 'Contact' -Template GenericList -Url 'Contact' -OnQuickLaunch
                        Write-Host 'Contact list has now been made' -ForegroundColor Green
                    }
                    $GetContact = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Contact'}
                    if($GetContact.EntityTypeName -eq 'Contact'){
                        if($GetContact.title -eq 'Contact'){
                            Write-Host 'Contact list has been found | Title: Contact' -ForegroundColor Gray
                        }else{
                            write-host 'Title was' $GetContact.Title 'now Contact' -ForegroundColor Red
                            Set-PnPList -Identity $GetContact.title -Title 'Contact'
                        }
                    }else{
                        Write-Host 'Contact list has not been found' -ForegroundColor Red
                        New-PnPList -Title 'Contact' -Template GenericList -Url 'Contact' -OnQuickLaunch
                        Write-Host 'Contact list has now been made' -ForegroundColor Green
                    }

                    if(Get-PnPField -List 'Contact'|Where-Object{$_.InternalName -eq 'postcode'}){
                        }else{ 
                            Write-Host 'Postcode field could not be found' -ForegroundColor Red
                            Add-PnPField -List 'Contact' -DisplayName 'Postcode' -InternalName 'postcode' -Type Text -AddToDefaultView
                            Write-Host 'Postcode field now added' -ForegroundColor Green
                        }

                    if(Get-PnPField -List 'Contact'|Where-Object{$_.InternalName -eq 'phone'}){
                        }else{
                            Write-Host 'phone field could not be found' -ForegroundColor Red
                            Add-PnPField -List 'Contact' -DisplayName 'phone' -InternalName 'phone' -Type Text -AddToDefaultView
                            Write-Host 'phone field now added' -ForegroundColor Green
                        }

                    if(Get-PnPField -List 'Contact'|Where-Object{$_.InternalName -eq 'City'}){
                        }else{
                            Write-Host 'City field could not be found' -ForegroundColor Red
                            Add-PnPField -List 'Contact' -DisplayName 'City' -InternalName 'City' -Type Text -AddToDefaultView
                            Write-Host 'City field now added' -ForegroundColor Green
                        }

                    #Management
                    if($Management1 -eq 'Yes'){
                        $GetManagement = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Management'}
                        if($GetManagement.EntityTypeName -eq 'Management'){
                                if($GetManagement.title -eq $Management){
                                    Write-Host $Management 'list has been found | Title:'$Management -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetManagement.Title 'now' $Management -ForegroundColor Red
                                    Set-PnPList -Identity $GetManagement.title -Title $Management
                                }
                        }else{
                            Write-Host 'The list' $Management 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Management -Template GenericList -Url $Management -OnQuickLaunch 
                            Write-Host $Management 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #Employees
                    if($Employees1 -eq 'Yes'){
                        $GetEmployees = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Employees'}
                        if($GetEmployees.EntityTypeName -eq 'Employees'){
                                if($GetEmployees.title -eq $Employees){
                                    Write-Host $Employees 'list has been found | Title:'$Employees -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetEmployees.Title 'now' $Employees -ForegroundColor Red
                                    Set-PnPList -Identity $GetEmployees.title -Title $Employees
                                }
                        }else{
                            Write-Host 'The list' $Employees 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Employees -Template GenericList -Url $Employees -OnQuickLaunch 
                            Write-Host $Employees 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #WorkActivities1
                    if($WorkActivities1 -eq 'Yes'){
                        $GetWorkActivities = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'WorkActivities'}
                        if($GetWorkActivities.EntityTypeName -eq 'WorkActivities'){
                                if($GetWorkActivities.title -eq $WorkActivities){
                                    Write-Host $WorkActivities 'list has been found | Title:'$WorkActivities -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetWorkActivities.Title 'now' $WorkActivities -ForegroundColor Red
                                    Set-PnPList -Identity $GetWorkActivities.title -Title $WorkActivities
                                }
                        }else{
                            Write-Host 'The list' $WorkActivities 'was not found' -ForegroundColor Red
                            New-PnPList -Title $WorkActivities -Template GenericList -Url $WorkActivities -OnQuickLaunch 
                            Write-Host $WorkActivities 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #Substances1
                    if($Substances1 -eq 'Yes'){
                        $GetSubstances = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Substances'}
                        if($GetSubstances.EntityTypeName -eq 'Substances'){
                                if($GetSubstances.title -eq $Substances){
                                    Write-Host $Substances 'list has been found | Title:'$Substances -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $GetSubstances.Title 'now' $Substances -ForegroundColor Red
                                    Set-PnPList -Identity $getSubstances.title -Title $Substances
                                }
                        }else{
                            Write-Host 'The list' $Substances 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Substances -Template GenericList -Url $Substances -OnQuickLaunch 
                            Write-Host $Substances 'list has now been made' -ForegroundColor Green
                        }
                    }
                    #Workplaces1
                    if($Workplaces1 -eq 'Yes'){
                        $GetWorkplaces = Get-PnPList | Where-Object {$_.EntityTypeName -eq 'Workplaces'}
                        if($GetWorkplaces.EntityTypeName -eq 'Workplaces'){
                                if($GetWorkplaces.title -eq $Workplaces){
                                    Write-Host $Workplaces 'list has been found | Title:'$Workplaces -ForegroundColor Gray 
                                }else{
                                    write-host 'Title was' $Workplaces.Title 'now' $Workplaces -ForegroundColor Red
                                    Set-PnPList -Identity $GetWorkplaces.title -Title $Workplaces
                                }
                        }else{
                            Write-Host 'The list' $Workplaces 'was not found' -ForegroundColor Red
                            New-PnPList -Title $Workplaces -Template GenericList -Url $Workplaces -OnQuickLaunch 
                            Write-Host $Workplaces 'list has now been made' -ForegroundColor Green
                        }
                    }
                }

    }#Foreach Group
}#Pram
