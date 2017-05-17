$computerName = 'DC1'
$commonPassword = 'demo!234'

$adminUsername = 'Administrator'
$adminPassword = $commonPassword

$domainName = 'adatum.com'
#
$currentScript = Get-LBCurrentFile
Set-LBRunOnceScript -LiteralPath $currentScript.FullName

Set-LBAutologon -Username $adminUsername -Password $adminPassword

Rename-LBComputer -NewName $computerName

$secAdminPassword = ConvertTo-SecureString -String $adminPassword -AsPlainText -Force
Add-LBDomainContoller -DomainName $domainName -SafeModeAdministratorPassword $secAdminPassword

Add-LBUser -SamAccountName 'holly' -DisplayName 'Holly Dickson' -Upn 'holly.dickson@adatum.com' -Password $commonPassword








