Write-Host @"
 __      __     __      __           _   _       _     _       
 \ \    / /     \ \    / /          | \ | |     | |   (_)      
  \ \  / /   _   \ \  / /_ _ _ __   |  \| | __ _| |__  _  __ _ 
   \ \/ / | | |   \ \/ / _` | '_ \  | . ` |/ _` | '_ \| |/ _` |
    \  /| |_| |    \  / (_| | | | | | |\  | (_| | | | | | (_| |
     \/  \__,_|     \/ \__,_|_| |_| |_| \_|\__, |_| |_|_|\__,_|
                                            __/ |              
                                           |___/               
"@

$CurrentPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
Write-Host "Current path: $CurrentPath"

#! Thay đổi hình nền Desktop
Write-Host "Change Desktop Wallpaper"

$wallpaperPath = Join-Path -Path $CurrentPath -ChildPath "wallpaper.jpeg"
Write-Host "File: $wallpaperPath"

Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper" -Value $wallpaperPath
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters ,1 ,True

#! Cài đặt theme màu đen
Write-Host "Setting black theme"

# $windows_registry_theme_white = Join-Path -Path $CurrentPath -ChildPath "windows_registry_theme_white.reg"
$windows_registry_theme_dark = Join-Path -Path $CurrentPath -ChildPath "windows_registry_theme_dark.reg"
# Write-Host "File: $windows_registry_theme_white"
Write-Host "File: $windows_registry_theme_dark"

# Regedit.exe /s $windows_registry_theme_white
Regedit.exe /s $windows_registry_theme_dark

# Khởi động lại Windows Explorer 
Stop-Process -Name explorer -Force
Start-Process explorer.exe

#! Bật hiển thị phần mở rộng tệp tin
Write-Host "Enable show file extensions"

$windows_registry_file_extensions_show = Join-Path -Path $CurrentPath -ChildPath "windows_registry_file_extensions_show.reg"
# $windows_registry_file_extensions_hide = Join-Path -Path $CurrentPath -ChildPath "windows_registry_file_extensions_hide.reg"
Write-Host "File: $windows_registry_file_extensions_show"
# Write-Host "File: $windows_registry_file_extensions_hide"

Regedit.exe /s $windows_registry_file_extensions_show
# Regedit.exe /s $windows_registry_file_extensions_hide
 
# Khởi động lại Windows Explorer 
Stop-Process -Name explorer -Force
Start-Process explorer.exe

#! Bật hiển thị các mục bị ẩn trong Windows Explorer
Write-Host "Enable showing hidden items in Windows Explorer"

$windows_registry_hidden_items_show = Join-Path -Path $CurrentPath -ChildPath "windows_registry_hidden_items_show.reg"
# $windows_registry_hidden_items_hide = Join-Path -Path $CurrentPath -ChildPath "windows_registry_hidden_items_hide.reg"
Write-Host "File: $windows_registry_hidden_items_show"
# Write-Host "File: $windows_registry_hidden_items_hide"

Regedit.exe /s $windows_registry_hidden_items_show
# Regedit.exe /s $windows_registry_hidden_items_hide

# Khởi động lại Windows Explorer 
Stop-Process -Name explorer -Force
Start-Process explorer.exe

#! Bật tính năng lịch sử Clipboard
Write-Host "Enable Clipboard history feature"

# $windows_registry_clipboard_history_disable = Join-Path -Path $CurrentPath -ChildPath "windows_registry_clipboard_history_disable.reg"
$windows_registry_clipboard_history_enable = Join-Path -Path $CurrentPath -ChildPath "windows_registry_clipboard_history_enable.reg"
# Write-Host "File: $windows_registry_clipboard_history_disable"
Write-Host "File: $windows_registry_clipboard_history_enable"

# Regedit.exe /s $windows_registry_clipboard_history_disable
Regedit.exe /s $windows_registry_clipboard_history_enable

# Khởi động lại Windows Explorer 
Stop-Process -Name explorer -Force
Start-Process explorer.exe

# ! Thay đổi vị trí ảnh chụp màn hình 
Write-Host "Change screenshot location"

$newScreenshotsPath = [System.IO.Path]::Combine($env:USERPROFILE, "Downloads\NghiaScreenshots")
Write-Host "Path: $newScreenshotsPath"

if (-Not (Test-Path -Path $newScreenshotsPath)) {
    New-Item -ItemType Directory -Path $newScreenshotsPath -Force
}

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{B7BEDE81-DF94-4682-A7D8-57A52620B86F}" -Value $newScreenshotsPath

# Khởi động lại Windows Explorer 
Stop-Process -Name explorer -Force
Start-Process explorer.exe

#! Tạo thư mục temp trong startup
Write-Host "Create temp folder in startup"

$startupPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
$tempFolderPath = [System.IO.Path]::Combine($startupPath, "temp")
Write-Host "startupPath: $startupPath"
Write-Host "tempFolderPath: $tempFolderPath"

if (-Not (Test-Path -Path $tempFolderPath)) {
    New-Item -ItemType Directory -Path $tempFolderPath -Force
    Write-Output "The folder 'temp' has been created at: $tempFolderPath"
} else {
    Write-Output "The folder 'temp' already exists at: $tempFolderPath"
}

#! Tạo shortcut của Startup trên Desktop
Write-Host "Create Startup shortcut on Desktop"

$startupPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
Write-Host "startupPath: $startupPath"
$desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "Desktop")
Write-Host "desktopPath: $desktopPath"
$desktopShortcutPath = [System.IO.Path]::Combine($desktopPath, "Startup.lnk")
Write-Host "desktopShortcutPath: $desktopShortcutPath"

$wshell = New-Object -ComObject WScript.Shell
$shortcut = $wshell.CreateShortcut($desktopShortcutPath)
$shortcut.TargetPath = $startupPath
$shortcut.WorkingDirectory = $startupPath
$shortcut.WindowStyle = 1
$shortcut.Description = "Shortcut to Startup Folder"
$shortcut.IconLocation = "shell32.dll, 34"
$shortcut.Save()
