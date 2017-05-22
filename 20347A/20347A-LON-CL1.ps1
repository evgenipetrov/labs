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
$adminSamAccount = '{0}\{1}' -f $domainName.Split('.')[0],$adminUsername
$credential = New-Object System.Management.Automation.PSCredential ($adminUsername, $secAdminPassword)

Join-LTDomainComputer -DomainName $domainName -Credential $credential
Set-LTAutologon -Username $adminSamAccount -Password $adminPassword

foreach ($localAdmin in $localAdmins)
{
  Add-LocalGroupMember -Group Administrators -Member $localAdmin
}
