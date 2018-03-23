<#
.Synopsis
This function is to connect to services.
.Description
This function is to connect to the PnP, Microsoft graph and the SPO services. 
.Parameter ComputerName
This is to allow the user to connect.
.Example
Get-RyanConnection, then type password
#>
function Get-RyanConnection{
    param(
         [Parameter()]
         $PnpSiteUrl
         )
    #To connect to the services 
    Write-Host "Connecting to PnP online" -ForegroundColor Cyan     
    Connect-PnPOnline -Url ("https://sharepoint121.sharepoint.com/"+$PnpSiteUrl) -Credentials Sysadmin
    Write-Host "Connecting to PnPonline" -ForegroundColor Green
    Write-Host "Connected to PnPGraph" -ForegroundColor Cyan        
    Connect-PnPOnline -AppId 671390a8-6a65-43c0-a3db-adcd615074ad -AppSecret "qagedHTOEW195%{?)ybOE03" -AADDomain "Fletcher-dev.co.uk"
    Write-Host "Connected to PnPGraph" -ForegroundColor Green  
    #Credential commands for SPO
    $CredentialURL = "https://sharepoint121-admin.sharepoint.com/"
    $Credential = "sysadmin@fletcher-dev.co.uk"
    Write-Host "Connecting to SPOService" -ForegroundColor Cyan 
    Connect-SPOService -Url $CredentialURL -Credential $Credential
    Write-Host "Connected to SPOService" -ForegroundColor Green
    Write-Host 'Connecting to Outlook' -ForegroundColor Cyan
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force -Scope CurrentUser
    $Credential = Get-Credential `
    -Credential sysadmin@fletcher-dev.co.uk
    $Session = New-PSSession `
    -ConnectionUri https://ps.outlook.com/Powershell `
    -ConfigurationName Microsoft.Exchange `
    -Credential $Credential `
    -Authentication Basic `
    -AllowRedirection
    $Exosession = Import-PSSession $Session -AllowClobber
    Write-Host 'Connected to Outlook' -ForegroundColor Green
}#end function


