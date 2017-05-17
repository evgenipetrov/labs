$newComputerName = 'WAP1'
#

# run everything as administrator
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value "0"

# rename computer
Rename-Computer -NewName $newComputerName -Restart

