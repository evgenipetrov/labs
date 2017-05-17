$newName = 'CL1'
$domainName = "adatum.com"
$adminUsername = 'administrator'
$adminPassword = 'demo!234'
#

# run everything as administrator
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value "0"

# rename computer
Rename-Computer -NewName $newName -Restart

# join computer to domain
$secAdminPassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($adminUsername, $secAdminPassword)
Add-Computer -DomainName $domainName -Credential $credential -Restart