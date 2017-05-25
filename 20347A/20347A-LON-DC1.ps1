$computerName = 'DC1'
$commonPassword = 'Pa$$w0rd'

$adminUsername = 'Administrator'
$adminPassword = $commonPassword

$domainName = 'adatum.com'

$domainUsers = @()
$domainUsers += @{'SamAccountName'='holly';'DisplayName'='Holly Dickson';'Upn'='holly.dickson@adatum.com';}
#

# 1. Rename Computer
Rename-LTComputer -NewName $computerName

# 2. Create Domain
$secAdminPassword = ConvertTo-SecureString -String $adminPassword -AsPlainText -Force
Add-LTDomainContoller -DomainName $domainName -SafeModeAdministratorPassword $secAdminPassword

# 3. Add Domain Users
foreach($domainUser in $domainUsers){
    Add-LTUser -SamAccountName $domainUser.SamAccountName -DisplayName $domainUser.DisplayName -Upn $domainUser.Upn -Password $commonPassword
}


# Unload module and cleanup.
Remove-Module PowerShell.LabTools






