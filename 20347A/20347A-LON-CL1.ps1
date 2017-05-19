$computerName = 'CL1'
$domainName = "adatum.com"
$adminUsername = 'administrator'
$adminPassword = 'Pa$$w0rd'
$localAdmins = @(
  'adatum\holly'
)
#

Enable-LTRunEverythingAsAdministrator

Rename-LTComputer -NewName $computerName

$currentScript = Get-LTCurrentFile
Set-LTRunOnceScript -LiteralPath $currentScript.FullName

Set-LTAutologon -Username $adminUsername -Password $adminPassword

$secAdminPassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($adminUsername, $secAdminPassword)
Join-LTDomainComputer -DomainName $domainName -Credential $credential

foreach ($localAdmin in $localAdmins)
{
  Add-LocalGroupMember -Group Administrators -Member $localAdmin
}

 
