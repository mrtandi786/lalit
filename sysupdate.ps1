# Ensure the script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

# Username and new password
$username = "localusr"
$newPassword = "c5!M3]Y82Ym8n88"

# Convert plain password to secure string
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force

try {
    # Set the new password for the user
    Set-LocalUser -Name $username -Password $securePassword
    Write-Host "Password for user '$username' has been changed successfully." -ForegroundColor Green
}
catch {
    Write-Host "Failed to change password: $($_.Exception.Message)" -ForegroundColor Red
}
