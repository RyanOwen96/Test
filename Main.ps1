 #To connect to the services 
Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/" -Credentials Sysadmin
Connect-PnPMicrosoftGraph -AppId 671390a8-6a65-43c0-a3db-adcd615074ad -AppSecret "qagedHTOEW195%{?)ybOE03" -AADDomain "Fletcher-dev.co.uk"
#Credential commands 
$CredentialURL = "https://sharepoint121-admin.sharepoint.com/"
$Credential = "sysadmin@fletcher-dev.co.uk"
Connect-SPOService -Url $CredentialURL -Credential $Credential
#All the get commands 
$GetGroup = Get-PnPUnifiedGroup
$GetSite = Get-SPOSite
$items = Get-PnPListItem -List "Main"
#$List1 = "Management"
#$List2 = "Employees"
#$List3 = "Activities"
#$List4 = "Equipment"
#$List5 = "Substances"
#$List6 = "Workplaces"
#$SiteField1 = "BSS Number"
#$SiteField2 = "Client Name"
#$SiteField3 = "Subjects"
#$SiteField4 = "Client"

    foreach($Item in $items){
        #To check there a group
        $OutCome = 0
        $EmailStatus = "Not Match"
        $Email = $Item["FriendlyName"]+"@fletcher-dev.co.uk"
        if($GetGroup | Where-Object {$_.GroupId -eq $Item["GroupID"]}){
            $Group1 = Get-PnPUnifiedGroup -Identity $Item["GroupID"]
            if($Group1.Mail -eq $Email){$EmailStatus = "Email match"}
            if($Group1.Mail -cnotmatch $Email){set-UnifiedGroup -Identity $Item["GroupID"] -EmailAddresses $Email 
            $EmailStatus = $item["Title"] + " Email has been changed"}
            $OutCome = 1
            $Status = $item["Title"] + " Group Found"
        }
    
        if($Item["Status"] -cnotmatch 1){
            $Group1 = Get-pnpUnifiedGroup -Identity $Item["Title2"]
            New-UnifiedGroup -DisplayName $Item["Title"] -Owner "Sysadmin@fletcher-dev.co.uk"`
            -Language (Get-Culture) -Alias $Item["BSS"] -EmailAddresses $Email
            $Status = $Item["Title"] + " Group Made"
        }
        Write-Host ($Status,$EmailStatus) -ForegroundColor Green -BackgroundColor Black -Separator " & "


        #To check the group site is  there 
        $SiteStatus = "No Site"
        If($GetSite | Where-Object{$_.Url -eq $Group1.SiteUrl}){
            Connect-PnPOnline -Url ("https://sharepoint121.sharepoint.com/sites/" + $Item["BSS"].ToString()) -Credentials Sysadmin
            $OutCome = 2 
            $SiteStatus = "There a site"
            Write-Host $SiteStatus -ForegroundColor Green -BackgroundColor Black -Separator " & "
            
            $Fields = "BSS Number","Client Name","Subjects","Client"
            #To check if the field is in the site
            foreach($Field in $Fields){
            $FieldOutcome = "No"
            if(Get-PnPField -Group "A" | Where-Object {$_.InternalName -eq $Field}){$FieldOutcome = $Field + " field already made"
                $SavedField = get-pnpfield -Identity $Field -Group "A"
                if($Field -eq "BSS Number"){Set-PnPField -Identity $SavedField.Title -Values @{"Title" = "BSS Number"}-UpdateExistingLists}
                if($Field -eq "Client Name"){Set-PnPField -Identity $SavedField.Title -Values @{"Title" = "Client Name"}-UpdateExistingLists}
                if($Field -eq "Subjects"){Set-PnPField -Identity $SavedField.Title -Values @{"Title" = "Subjects"}-UpdateExistingLists}
                if($Field -eq "Client"){Set-PnPField -Identity $SavedField.Title -Values @{"Title" = "Client"}-UpdateExistingLists}}
            if($FieldOutcome -eq "No"){Add-PnPField -DisplayName $Field -InternalName $Field -Type Text -Group "A"
            $FieldOutcome = "Site field "+$Field+" field was created"}
            Write-Host $FieldOutcome -ForegroundColor Green -BackgroundColor Black}

            #To check if Management list is there 
            $Lists ="Management","Employees","Activities","Equipment","Substances","Workplaces"
            foreach($List in $Lists){
                $ListOutcome = 0
                #There a List
                if(Get-PnPList | Where-Object {$_.EntityTypeName -eq $List}){$ListOutcome = $List + " List is already made"
                $GetList =Get-PnPList |Where-Object{$_.EntityTypeName -eq $List}
                $ListStatus = "Error"
                if($GetList.EntityTypeName -eq "Management"){Set-PnPList -Identity $GetList.Title -Title "Management"
                $ListStatus = $GetList.Title + "Changed"}
                if($GetList.EntityTypeName -eq "Employees"){Set-PnPList -Identity $GetList.Title -Title "Employees"
                $ListStatus = $GetList.Title + "Changed"}
                if($GetList.EntityTypeName -eq "Activities"){Set-PnPList -Identity $GetList.Title -Title "Activities"
                $ListStatus = $GetList.Title + "Changed"}
                if($GetList.EntityTypeName -eq "Equipment"){Set-PnPList -Identity $GetList.Title -Title "Equipment"
                $ListStatus = $GetList.Title + "Changed"}
                if($GetList.EntityTypeName -eq "Substances"){Set-PnPList -Identity $GetList.Title -Title "Substances"
                $ListStatus = $GetList.Title + "Changed"}
                if($GetList.EntityTypeName -eq "Workplaces"){Set-PnPList -Identity $GetList.Title -Title "Workplaces"
                $ListStatus = $GetList.Title + "Changed"}

                Write-Host ($ListOutcome,$ListStatus) -ForegroundColor Green -BackgroundColor Black -Separator " & "

                    $BSS = 0
                    $ClientName = 0
                    $Subjects = 0
                    $Client = 0
                    
                    Write-Host $List -ForegroundColor Blue -BackgroundColor Black
                    if(Get-PnPfield -List $List | Where-Object {$_.EntityPropertyName -eq "BSS_x0020_Number"}){
                        $BSS = "   BSS Number Field Already Made"}
                    if($BSS -eq 0){Add-PnPField -List $List -Field "BSS Number"
                        $BSS = "   BSS Number Field Created"}
                    
                    if(Get-PnPfield -List $List | Where-Object {$_.EntityPropertyName -eq "Client_x0020_Name"}){
                        $ClientName = "   Client Name Field Already Made"}
                    if($ClientName -eq 0){Add-PnPField -List $List -Field "Client Name"
                        $ClientName = "   Client Name Field Created"}
                    
                    if(Get-PnPfield -List $List | Where-Object {$_.EntityPropertyName -eq "Subjects"}){
                        $Subjects = "   Subject Field Already Made"}
                    if($Subjects -eq 0){Add-PnPField -List $List -Field "Subjects"
                        $Subjects = "   Subject Field Created"} 
                
                    if(Get-PnPfield -List $List | Where-Object {$_.EntityPropertyName -eq "Client"}){
                        $Client = "   Client Field Already Made"}
                    if($Client -eq 0){Add-PnPField -List $List -Field  "Client"
                        $Client = "   Client Field Created"} 
                    Write-Host ($BSS,$ClientName,$Subjects,$Client) -ForegroundColor Green -BackgroundColor Black -Separator "
                    "
                        
                    $views = Get-PnPView -List $List 
                    foreach($view in $views){Remove-PnPView -Identity $view.Title -List $List -Force}
                    Add-PnPView -Title "All Items" -List $List -Fields "BSS Number","Client Name","Subjects","Client" -SetAsDefault | Format-Table "Title" -HideTableHeaders -}
                #No list
                if($ListOutcome -eq 0){New-PnPList -Title $List -Template GenericList -Url $List -OnQuickLaunch
                Add-PnPField -List $List -Field "BSS Number"
                Add-PnPField -List $List -Field "Client Name"
                Add-PnPField -List $List -Field "Subjects"
                Add-PnPField -List $List -Field "Client"
                $views = Get-PnPView -List $List 
                foreach($view in $views){Remove-PnPView -Identity $view.Title -List $List -Force}
                Add-PnPView -Title "All Items" -List $List -Fields "BSS Number","Client Name","Subjects","Client" -SetAsDefault | Format-Table "Title"  -HideTableHeaders}
                $NewListOutcome = $List +" list was created"}
                Write-Host $NewListOutcome -ForegroundColor Green -BackgroundColor Black
            }
            #Set the field items
            Connect-PnPOnline -Url "https://sharepoint121.sharepoint.com/" -Credentials Sysadmin
            if($item["Title"] + " Group Found"){$Group = Get-PnPUnifiedGroup -Identity $Item["GroupID"]
            Set-PnPListItem -List "Main" -Identity $Item.Id -Values @{"GroupID" = $Group.GroupId}}
            if($Status -eq $Item["Title"] + " Group Made"){$Group = Get-PnPUnifiedGroup -Identity $Item["BSS"]
            Set-PnPListItem -List "Main" -Identity $Item.Id -Values @{"Status" = 1;"Title2"=$Item["BSS"];"GroupID" = $Group.GroupId}}
        }
