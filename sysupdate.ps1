# Run as Administrator

Write-Host "🔧 Starting full system hardening process..." -ForegroundColor Cyan

### ---- CHANGE PASSWORD ---- ###
Write-Host "`n🔑 Changing password for user 'localusr'..."
$UserName = "localusr"
$NewPassword = ConvertTo-SecureString "l8@XK!th94pOhQ;" -AsPlainText -Force
Set-LocalUser -Name $UserName -Password $NewPassword
Write-Host "✅ Password updated for 'localusr'."

### ---- DEFENDER CONFIGURATION ---- ###
Write-Host "`n🛡️ Enabling Microsoft Defender..."
Start-Service -Name WinDefend -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 0 -Force

# Core Defender Protections
Set-MpPreference -DisableRealtimeMonitoring $false
Set-MpPreference -DisableBehaviorMonitoring $false
Set-MpPreference -DisableIOAVProtection $false
Set-MpPreference -DisableOnAccessProtection $false
Set-MpPreference -DisableScriptScanning $false

# Cloud + Threat Response
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent SendSafeSamples
Set-MpPreference -DisableBlockAtFirstSeen $false

# Network Protection
Set-MpPreference -EnableNetworkProtection Enabled

# Controlled Folder Access
Set-MpPreference -EnableControlledFolderAccess Enabled

# PUA Protection
Set-MpPreference -PUAProtection Enabled

Write-Host "✅ Defender is fully enabled."

### ---- FIREWALL CONFIGURATION ---- ###
Write-Host "`n🔥 Enabling Windows Firewall for all profiles..."
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True
Write-Host "✅ Windows Firewall is enabled."

### ---- DISABLE REMOTE DESKTOP ---- ###
Write-Host "`n🚫 Disabling Remote Desktop (RDP)..."
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 1

# Optionally stop and disable Remote Desktop Services
# Stop-Service -Name TermService -Force
# Set-Service -Name TermService -StartupType Disabled

Write-Host "`n✅✅✅ All protections applied successfully!" -ForegroundColor Green
