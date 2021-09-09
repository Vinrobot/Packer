Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Disable all rules in the 'Windows Remote Management' group
Disable-NetFirewallRule -DisplayGroup 'Windows Remote Management'

# Delete any existing WinRM listeners
Get-ChildItem WSMan:\localhost\Listener | Remove-Item -Recurse

# Update existing networks to 'Private'
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
$NetworkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
$NetworkListManager.GetNetworkConnections() | ForEach-Object { $_.GetNetwork().SetCategory(1) }

# Add new firewall rule
New-NetFirewallRule -Name 'WINRM-HTTPS-In-TCP' `
	-DisplayName 'Windows Remote Management (HTTPS-In)' `
	-Description 'Inbound rule for Windows Remote Management via WS-Management. [TCP 5986]' `
	-Group 'Windows Remote Management' `
	-Program System `
	-Protocol TCP `
	-LocalPort 5986 `
	-Action Allow `
	-Profile Domain,Private

# Add HTTPS listeners
$hostname = [System.Net.Dns]::GetHostName().ToUpper()
$cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName $hostname
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $cert.Thumbprint -Hostname $hostname -Port 5986 -Force

# Tune WinRM
Set-Item -Path WSMan:\localhost\MaxTimeoutms -Value 180000 -Force
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value * -Force
Set-Item -Path WSMan:\localhost\Client\Auth\Basic -Value true -Force
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value true -Force
Set-Item -Path WSMan:\localhost\Service\Auth\CredSSP -Value true -Force
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value false -Force
Set-Item -Path WSMan:\localhost\Shell\MaxMemoryPerShellMB -Value 1024 -Force

# Required for NTLM auth
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'LmCompatibilityLevel' -Value 2 -Type DWord -Force
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0' -Name 'NTLMMinServerSec' -Value 0x20000000 -Type DWord -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LocalAccountTokenFilterPolicy' -Value 1 -Force

# Start service
Set-Service -Name WinRM -StartupType Automatic
Restart-Service -Name WinRM

# Enable firewall rule
Enable-NetFirewallRule -Name 'WINRM-HTTPS-In-TCP'
