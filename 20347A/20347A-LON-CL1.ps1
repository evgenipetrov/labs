$computerName = 'CL1'
$commonPassword = 'Pa$$w0rd'

$adminUsername = 'Administrator'
$adminPassword = $commonPassword

$domainName = "adatum.com"

$localAdmins = @('adatum\holly')
#

Enable-LTRunEverythingAsAdministrator

$currentScript = Get-LTCurrentFile
Set-LTRunOnceScript -LiteralPath $currentScript.FullName

Set-LTAutologon -Username $env:USERNAME -Password $commonPassword
Rename-LTComputer -NewName $computerName

$secAdminPassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($adminUsername, $secAdminPassword)
Set-LTAutologon -Username $adminUsername -Password $adminPassword
Join-LTDomainComputer -DomainName $domainName -Credential $credential

foreach ($localAdmin in $localAdmins)
{
  Add-LocalGroupMember -Group Administrators -Member $localAdmin
}
