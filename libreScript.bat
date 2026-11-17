@echo off
:: ============================================================================
::  libreScript - Zero-Bloat Windows 11 & 10 Optimization & Debloat Framework
::  Author: PolskieWin / Libre Project
::  License: MIT
::  GitHub: https://github.com/PolskieWin/libreScript
:: ============================================================================

setlocal EnableExtensions EnableDelayedExpansion
title libreScript - Windows 11 ^& 10 Optimization Engine

:: --- UAC SELF-ELEVATION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [!] libreScript requires Administrator privileges.
    echo  [*] Requesting elevation via UAC...
    echo.
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -ArgumentList '%*' -Verb RunAs"
    exit /b %errorlevel%
)

:: --- ARGUMENT PARSING (CLI MODE) ---
if /i "%~1"=="/all"      goto :CLI_ALL
if /i "%~1"=="/clean"    goto :CLI_CLEAN
if /i "%~1"=="/privacy"  goto :CLI_PRIVACY
if /i "%~1"=="/gaming"   goto :CLI_GAMING
if /i "%~1"=="/network"  goto :CLI_NETWORK
if /i "%~1"=="/visuals"  goto :CLI_VISUALS
if /i "%~1"=="/repair"   goto :CLI_REPAIR
if /i "%~1"=="/restore"  goto :CLI_RESTORE
if /i "%~1"=="/revert"   goto :CLI_REVERT
if /i "%~1"=="/help"     goto :CLI_HELP
if /i "%~1"=="--all"     goto :CLI_ALL
if /i "%~1"=="--help"    goto :CLI_HELP
if /i "%~1"=="-h"        goto :CLI_HELP
if /i "%~1"=="/?"        goto :CLI_HELP

:: --- MAIN INTERACTIVE MENU ---
:MAIN_MENU
cls
echo ============================================================================
echo   _ _ _               ____            _       _   
echo  ^| (_) ^|__  _ __ ___ / ___^|  ___ _ __(_)_ __ ^| ^|_ 
echo  ^| ^| ^| '_ \^| '__/ _ \\___ \ / __^| '__^| ^| '_ \^| __^|
echo  ^| ^| ^| ^|_) ^| ^| ^|  __/ ___) ^| (__^| ^|  ^| ^| ^|_) ^| ^|_ 
echo  ^|_^|_^|_.__/^|_^|  \___^|^|____/ \___^|_^|  ^|_^| .__/ \__^|
echo                                        ^|_^|        
echo   Universal Windows 11 ^& 10 Nuclear Purge ^& Latency Optimization Engine
echo   Repository: https://github.com/PolskieWin/libreScript
echo ============================================================================
echo.
echo   [1] COMPLETE NUCLEAR PURGE (Recommended: Restore + Clean + Debloat + Game)
echo   [2] Deep Cache ^& Slop Purge (Temp, Prefetch, SoftwareDist, Shaders)
echo   [3] AI, Copilot, Recall ^& Telemetry Neutralization
echo   [4] Gaming, Kernel ^& Hardware Latency Tweaks (HAGS, IRQ8, Power, CPU)
echo   [5] Network Stack ^& File System Latency Optimization
echo   [6] Windows 11 QoL ^& Visual Tweaks (Classic Context Menu, Clean Search)
echo   [7] System Integrity Deep Scan (DISM /RestoreHealth + SFC /ScanNow)
echo   [8] Create System Restore Point (Standalone Safety Checkpoint)
echo   [9] Revert Core Tweaks to Windows Defaults
echo   [0] Exit
echo.
echo ============================================================================
set /p "CHOICE=  Select an option [0-9]: "

if "%CHOICE%"=="1" goto :ACTION_ALL
if "%CHOICE%"=="2" goto :ACTION_CLEAN
if "%CHOICE%"=="3" goto :ACTION_PRIVACY
if "%CHOICE%"=="4" goto :ACTION_GAMING
if "%CHOICE%"=="5" goto :ACTION_NETWORK
if "%CHOICE%"=="6" goto :ACTION_VISUALS
if "%CHOICE%"=="7" goto :ACTION_REPAIR
if "%CHOICE%"=="8" goto :ACTION_RESTORE
if "%CHOICE%"=="9" goto :ACTION_REVERT
if "%CHOICE%"=="0" goto :ACTION_EXIT

echo.
echo  [!] Invalid selection. Please choose an option between 0 and 9.
timeout /t 2 >nul
goto :MAIN_MENU

:: ============================================================================
::  ACTION HANDLERS (MENU CALLS)
:: ============================================================================
:ACTION_ALL
call :SUB_BANNER "COMPLETE NUCLEAR PURGE"
call :DO_RESTORE
call :DO_CLEAN
call :DO_PRIVACY
call :DO_GAMING
call :DO_NETWORK
call :DO_VISUALS
echo.
echo ============================================================================
echo  [OK] NUCLEAR PURGE FINISHED SUCCESSFULLY!
echo  [*] A system restart is required to apply all kernel and scheduling tweaks.
echo ============================================================================
echo.
set /p "REBOOT_NOW=  Restart computer now? [Y/N]: "
if /i "%REBOOT_NOW%"=="Y" (
    echo  [*] Restarting system in 5 seconds...
    shutdown /r /t 5 /c "libreScript: Finalizing optimization purge"
    exit /b 0
)
pause
goto :MAIN_MENU

:ACTION_CLEAN
call :SUB_BANNER "DEEP CACHE & SLOP PURGE"
call :DO_CLEAN
echo  [OK] Cleanup completed.
pause
goto :MAIN_MENU

:ACTION_PRIVACY
call :SUB_BANNER "AI, RECALL & TELEMETRY DEBLOAT"
call :DO_PRIVACY
echo  [OK] AI and telemetry purge applied.
pause
goto :MAIN_MENU

:ACTION_GAMING
call :SUB_BANNER "KERNEL & HARDWARE LATENCY OPTIMIZATION"
call :DO_GAMING
echo  [OK] Hardware latency optimizations applied. Restart recommended.
pause
goto :MAIN_MENU

:ACTION_NETWORK
call :SUB_BANNER "NETWORK & FILE SYSTEM OPTIMIZATION"
call :DO_NETWORK
echo  [OK] Network optimizations applied.
pause
goto :MAIN_MENU

:ACTION_VISUALS
call :SUB_BANNER "WINDOWS 11 QUALITY-OF-LIFE TWEAKS"
call :DO_VISUALS
echo  [OK] Interface tweaks applied.
pause
goto :MAIN_MENU

:ACTION_REPAIR
call :SUB_BANNER "SYSTEM INTEGRITY SCAN & REPAIR"
call :DO_REPAIR
echo  [OK] System integrity scan finished.
pause
goto :MAIN_MENU

:ACTION_RESTORE
call :SUB_BANNER "CREATE SYSTEM RESTORE POINT"
call :DO_RESTORE
pause
goto :MAIN_MENU

:ACTION_REVERT
call :SUB_BANNER "REVERT TWEAKS TO DEFAULTS"
call :DO_REVERT
echo  [OK] Revert script completed.
pause
goto :MAIN_MENU

:ACTION_EXIT
echo.
echo  Exiting libreScript. Stay lightweight and zero-bloat.
timeout /t 1 >nul
exit /b 0

:: ============================================================================
::  CLI DIRECT MODES
:: ============================================================================
:CLI_ALL
call :DO_RESTORE
call :DO_CLEAN
call :DO_PRIVACY
call :DO_GAMING
call :DO_NETWORK
call :DO_VISUALS
echo [OK] libreScript unattended run complete.
exit /b 0

:CLI_CLEAN
call :DO_CLEAN
exit /b 0

:CLI_PRIVACY
call :DO_PRIVACY
exit /b 0

:CLI_GAMING
call :DO_GAMING
exit /b 0

:CLI_NETWORK
call :DO_NETWORK
exit /b 0

:CLI_VISUALS
call :DO_VISUALS
exit /b 0

:CLI_REPAIR
call :DO_REPAIR
exit /b 0

:CLI_RESTORE
call :DO_RESTORE
exit /b 0

:CLI_REVERT
call :DO_REVERT
exit /b 0

:CLI_HELP
echo libreScript - Command-line interface usage:
echo   libreScript.bat [option]
echo.
echo Options:
echo   /all      Run complete nuclear purge unattended (Restore, Clean, Privacy, Gaming, Network)
echo   /clean    Wipe temp, prefetch, shader cache, and error dumps
echo   /privacy  Neutralize AI, Recall, Copilot, diagnostics and telemetry
echo   /gaming   Apply CPU core unparking, GPU scheduling, power and kernel tweaks
echo   /network  Optimize TCP stack, TCPNoDelay, and file system latency
echo   /visuals  Apply classic context menu and clean taskbar search
echo   /repair   Run DISM /RestoreHealth and SFC /scannow
echo   /restore  Create a mandatory System Restore Point
echo   /revert   Restore default Windows settings
echo   /help     Show this help screen
exit /b 0

:: ============================================================================
::  MODULAR IMPLEMENTATION ROUTINES
:: ============================================================================

:SUB_BANNER
cls
echo ============================================================================
echo   libreScript :: %~1
echo ============================================================================
echo.
exit /b 0

:: --- 1. SYSTEM RESTORE POINT ---
:DO_RESTORE
echo [*] Checking System Restore configuration...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\' -ErrorAction SilentlyContinue; Checkpoint-Computer -Description 'Before_libreScript_Purge' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] System Restore Point 'Before_libreScript_Purge' created.
) else (
    echo [!] Note: If System Protection is disabled by policy, verify in system settings.
)
exit /b 0

:: --- 2. DEEP CLEAN & CACHE PURGE ---
:DO_CLEAN
echo [*] Halting update and caching background services...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop sysmain >nul 2>&1
net stop dosvc >nul 2>&1

echo [*] Purging temporary files and system bloat...
del /f /s /q "%TEMP%\*.*" >nul 2>&1
for /d %%p in ("%TEMP%\*") do rmdir /s /q "%%p" >nul 2>&1

del /f /s /q "%SYSTEMROOT%\Temp\*.*" >nul 2>&1
for /d %%p in ("%SYSTEMROOT%\Temp\*") do rmdir /s /q "%%p" >nul 2>&1

del /f /s /q "%SYSTEMROOT%\Prefetch\*.*" >nul 2>&1
del /f /s /q "%SYSTEMROOT%\SoftwareDistribution\Download\*.*" >nul 2>&1
for /d %%p in ("%SYSTEMROOT%\SoftwareDistribution\Download\*") do rmdir /s /q "%%p" >nul 2>&1

echo [*] Purging DirectX and GPU shader caches...
del /f /s /q "%LOCALAPPDATA%\D3DSCache\*.*" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\NVIDIA\DXCache\*.*" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\AMD\DxCache\*.*" >nul 2>&1

echo [*] Purging explorer thumbnail caches and crash dumps...
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache_*.db" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\CrashDumps\*.*" >nul 2>&1
del /f /s /q "%SYSTEMROOT%\Minidump\*.*" >nul 2>&1

echo [*] Restarting background services...
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
exit /b 0

:: --- 3. PRIVACY, AI, COPILOT & TELEMETRY ---
:DO_PRIVACY
echo [*] Disabling Windows Recall & AI Data Analysis...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disabling Windows Copilot system-wide...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disabling Cortana and Bing Web Search in Start Menu...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Neutralizing Diagnostic Telemetry & Feedback requests...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Halting and disabling telemetry tracking services...
sc config DiagTrack start=disabled >nul 2>&1
net stop DiagTrack >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
net stop dmwappushservice >nul 2>&1

echo [*] Disabling sponsored app suggestions and silent installs...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Preventing sudden forced automatic reboots during active sessions...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
exit /b 0

:: --- 4. HARDWARE, KERNEL & GAMING ---
:DO_GAMING
echo [*] Disabling Memory Compression latency overhead...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-MMAgent -mc" >nul 2>&1

echo [*] Disabling CPU Power Throttling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Unparking all CPU Cores for maximum gaming frame stability...
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c362-4b78-8104-630237a18c08 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100 >nul 2>&1
powercfg -setactive scheme_current >nul 2>&1

echo [*] Activating Ultimate Performance Power Plan...
set "UP_GUID="
for /f "tokens=4" %%a in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul') do (
    set "UP_GUID=%%a"
)
if defined UP_GUID (
    powercfg -setactive !UP_GUID! >nul 2>&1
    echo [OK] Ultimate Performance Plan activated (!UP_GUID!).
) else (
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    echo [OK] High Performance Plan activated.
)

echo [*] Shifting System Timer (IRQ8) to High Priority...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disabling Dynamic Tick for smoother frame pacing...
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set useplatformclock no >nul 2>&1

echo [*] Enabling Hardware-Accelerated GPU Scheduling (HAGS)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1

echo [*] Optimizing Multimedia & Gaming Task Priority (MMCSS)...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
exit /b 0

:: --- 5. NETWORK & FILE SYSTEM ---
:DO_NETWORK
echo [*] Disabling 8.3 legacy short-name generation (NTFS speedup)...
fsutil behavior set disable8dot3 1 >nul 2>&1

echo [*] Disabling NTFS last access timestamp updates...
fsutil behavior set disablelastaccess 1 >nul 2>&1

echo [*] Disabling network throttling index...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1

echo [*] Tuning Windows TCP/IP networking stack...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1

echo [*] Setting TCPNoDelay and TcpAckFrequency on network interfaces...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$path = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces'; Get-ChildItem $path | ForEach-Object { New-ItemProperty -Path $_.PSPath -Name 'TcpAckFrequency' -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue; New-ItemProperty -Path $_.PSPath -Name 'TCPNoDelay' -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue } | Out-Null" >nul 2>&1
exit /b 0

:: --- 6. WINDOWS 11 QOL & VISUAL TWEAKS ---
:DO_VISUALS
echo [*] Restoring classic Windows 10 right-click context menu...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f >nul 2>&1

echo [*] Setting compact search icon on taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Removing application launch startup delays...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Refreshing Windows Explorer shell...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe >nul 2>&1
exit /b 0

:: --- 7. DISM & SFC REPAIR ---
:DO_REPAIR
echo [*] Initiating Windows Component Store check (DISM)...
echo     (This may take several minutes. Please do not close this window.)
DISM.exe /Online /Cleanup-Image /RestoreHealth
echo.
echo [*] Running System File Checker (SFC)...
sfc /scannow
exit /b 0

:: --- 8. REVERT TO WINDOWS DEFAULTS ---
:DO_REVERT
echo [*] Restoring default context menu...
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1

echo [*] Restoring standard telemetry settings...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Re-enabling telemetry services...
sc config DiagTrack start=auto >nul 2>&1
net start DiagTrack >nul 2>&1

echo [*] Resetting TCP stack to default autotuning...
netsh int ip reset >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global timestamps=allowed >nul 2>&1

echo [*] Resetting Power Plan to Balanced...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1

echo [*] Restarting Explorer shell...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe >nul 2>&1
exit /b 0
