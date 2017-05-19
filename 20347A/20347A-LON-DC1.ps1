$computerName = 'DC1'
$commonPassword = 'Pa$$w0rd'

$domainName = 'adatum.com'
$domainNetbiosName = $domainName.Split('.')[0]

$adminUsername = '{0}\Administrator' -f $domainNetbiosName
$adminPassword = $commonPassword

$domainUsers = @()
$domainUsers += @{'SamAccountName'='holly';'DisplayName'='Holly Dickson';'Upn'='holly.dickson@adatum.com';}
#
$currentScript = Get-LTCurrentFile
Set-LTRunOnceScript -LiteralPath $currentScript.FullName

Set-LTAutologon -Username $adminUsername -Password $adminPassword

Rename-LTComputer -NewName $computerName

$secAdminPassword = ConvertTo-SecureString -String $adminPassword -AsPlainText -Force
Add-LTDomainContoller -DomainName $domainName -SafeModeAdministratorPassword $secAdminPassword

foreach($domainUser in $domainUsers){
    Add-LTUser -SamAccountName $domainUser.SamAccountName -DisplayName $domainUser.DisplayName -Upn $domainUser.Upn -Password $commonPassword
}


Remove-Module PowerShell.LabTools






