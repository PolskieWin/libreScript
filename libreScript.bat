@echo off
:: ============================================================================
::  libreScript - Windows Optimization & Debloat Framework
::  Author: PolskieWin / Libre Project
::  License: MIT
::  GitHub: https://github.com/PolskieWin/libreScript
:: ============================================================================

setlocal EnableExtensions EnableDelayedExpansion
title libreScript - Windows Optimization Utility

:: --- ANSI COLOR INITIALIZATION ---
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C_RESET=%ESC%[0m"
set "C_BOLD=%ESC%[1m"
set "C_DIM=%ESC%[2m"
set "C_RED=%ESC%[91m"
set "C_GREEN=%ESC%[92m"
set "C_YELLOW=%ESC%[93m"
set "C_BLUE=%ESC%[94m"
set "C_MAGENTA=%ESC%[95m"
set "C_CYAN=%ESC%[96m"
set "C_WHITE=%ESC%[97m"
set "C_GRAY=%ESC%[90m"

:: --- UAC SELF-ELEVATION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  %C_RED%[!] libreScript requires Administrator privileges.%C_RESET%
    echo  %C_CYAN%[*] Requesting elevation via UAC...%C_RESET%
    echo.
    if "%~1"=="" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    ) else (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -ArgumentList '%*' -Verb RunAs"
    )
    exit /b %errorlevel%
)

:: --- OS VERSION & ARCHITECTURE DETECTION ---
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do set "WIN_BUILD=%%i.%%j.%%k" 2>nul
if not defined WIN_BUILD set "WIN_BUILD=Windows NT"

:: --- ARGUMENT PARSING (HEADLESS CLI MODE) ---
if /i "%~1"=="/all"      goto :CLI_ALL
if /i "%~1"=="--all"     goto :CLI_ALL
if /i "%~1"=="/bloat"    goto :CLI_BLOAT
if /i "%~1"=="--bloat"   goto :CLI_BLOAT
if /i "%~1"=="/privacy"  goto :CLI_PRIVACY
if /i "%~1"=="--privacy" goto :CLI_PRIVACY
if /i "%~1"=="/gaming"   goto :CLI_GAMING
if /i "%~1"=="--gaming"  goto :CLI_GAMING
if /i "%~1"=="/network"  goto :CLI_NETWORK
if /i "%~1"=="--network" goto :CLI_NETWORK
if /i "%~1"=="/clean"    goto :CLI_CLEAN
if /i "%~1"=="--clean"   goto :CLI_CLEAN
if /i "%~1"=="/visuals"  goto :CLI_VISUALS
if /i "%~1"=="--visuals" goto :CLI_VISUALS
if /i "%~1"=="/repair"   goto :CLI_REPAIR
if /i "%~1"=="--repair"  goto :CLI_REPAIR
if /i "%~1"=="/restore"  goto :CLI_RESTORE
if /i "%~1"=="--restore" goto :CLI_RESTORE
if /i "%~1"=="/revert"   goto :CLI_REVERT
if /i "%~1"=="--revert"  goto :CLI_REVERT
if /i "%~1"=="/help"     goto :CLI_HELP
if /i "%~1"=="--help"    goto :CLI_HELP
if /i "%~1"=="-h"        goto :CLI_HELP
if /i "%~1"=="/?"        goto :CLI_HELP

:: ============================================================================
::  MAIN INTERACTIVE MENU
:: ============================================================================
:MAIN_MENU
cls
echo %C_CYAN%
echo   _ _ _               ____            _       _   
echo  ^| (_) ^|__  _ __ ___ / ___^|  ___ _ __(_)_ __ ^| ^|_ 
echo  ^| ^| ^| '_ \^| '__/ _ \\___ \ / __^| '__^| ^| '_ \^| __^|
echo  ^| ^| ^| ^|_) ^| ^| ^|  __/ ___) ^| (__^| ^|  ^| ^| ^|_) ^| ^|_ 
echo  ^|_^|_^|_.__/^|_^|  \___^|^|____/ \___^|_^|  ^|_^| .__/ \__^|
echo                                         ^|_^|        
echo %C_RESET%
echo %C_GRAY%[=============================================================================]%C_RESET%
echo  %C_GREEN%[*] Utility     : %C_WHITE%libreScript - Clean Windows Optimization Framework%C_RESET%
echo  %C_GREEN%[*] Privilege   : %C_CYAN%Administrator Elevated%C_RESET%
echo  %C_GREEN%[*] Platform    : %C_WHITE%Windows [%PROCESSOR_ARCHITECTURE%] :: %WIN_BUILD%%C_RESET%
echo  %C_GREEN%[*] Safety      : %C_YELLOW%Safe guardrails active (Microsoft Store ^& system tools kept)%C_RESET%
echo %C_GRAY%[=============================================================================]%C_RESET%
echo.
echo %C_CYAN%  [01] %C_WHITE%Full System Optimization   %C_GRAY%-- %C_GREEN%Restore point, bloatware, telemetry, latency, clean%C_RESET%
echo %C_CYAN%  [02] %C_WHITE%Remove Bloatware Apps      %C_GRAY%-- %C_GREEN%Safe removal of preinstalled consumer apps (keeps Store)%C_RESET%
echo %C_CYAN%  [03] %C_WHITE%Disable Telemetry ^& AI     %C_GRAY%-- %C_GREEN%Turn off Copilot, Recall, and diagnostic tracking%C_RESET%
echo %C_CYAN%  [04] %C_WHITE%Performance ^& Latency      %C_GRAY%-- %C_GREEN%CPU unparking, timer priority, power scheme, GameDVR%C_RESET%
echo %C_CYAN%  [05] %C_WHITE%Network Stack Tuning       %C_GRAY%-- %C_GREEN%TCPNoDelay, Receive Side Scaling, DNS cache optimization%C_RESET%
echo %C_CYAN%  [06] %C_WHITE%Clean Temporary Files      %C_GRAY%-- %C_GREEN%Clear user temp, prefetch, shader caches, and update logs%C_RESET%
echo %C_CYAN%  [07] %C_WHITE%Interface Adjustments      %C_GRAY%-- %C_GREEN%Restore classic context menu, clean search bar, zero delay%C_RESET%
echo %C_CYAN%  [08] %C_WHITE%System File Verification   %C_GRAY%-- %C_GREEN%Run DISM image repair and SFC integrity scan%C_RESET%
echo %C_CYAN%  [09] %C_WHITE%Create Restore Point       %C_GRAY%-- %C_GREEN%Generate a manual System Restore checkpoint%C_RESET%
echo %C_CYAN%  [10] %C_WHITE%Restore Default Settings   %C_GRAY%-- %C_YELLOW%Revert applied optimizations back to Windows defaults%C_RESET%
echo %C_CYAN%  [00] %C_WHITE%Exit                      %C_GRAY%-- %C_RED%Close libreScript%C_RESET%
echo.
echo %C_GRAY%[=============================================================================]%C_RESET%
set /p "CHOICE=%C_GREEN%  Select an option [0-10]: %C_RESET%"

if "%CHOICE%"=="1"  goto :ACTION_ALL
if "%CHOICE%"=="01" goto :ACTION_ALL
if "%CHOICE%"=="2"  goto :ACTION_BLOAT
if "%CHOICE%"=="02" goto :ACTION_BLOAT
if "%CHOICE%"=="3"  goto :ACTION_PRIVACY
if "%CHOICE%"=="03" goto :ACTION_PRIVACY
if "%CHOICE%"=="4"  goto :ACTION_GAMING
if "%CHOICE%"=="04" goto :ACTION_GAMING
if "%CHOICE%"=="5"  goto :ACTION_NETWORK
if "%CHOICE%"=="05" goto :ACTION_NETWORK
if "%CHOICE%"=="6"  goto :ACTION_CLEAN
if "%CHOICE%"=="06" goto :ACTION_CLEAN
if "%CHOICE%"=="7"  goto :ACTION_VISUALS
if "%CHOICE%"=="07" goto :ACTION_VISUALS
if "%CHOICE%"=="8"  goto :ACTION_REPAIR
if "%CHOICE%"=="08" goto :ACTION_REPAIR
if "%CHOICE%"=="9"  goto :ACTION_RESTORE
if "%CHOICE%"=="09" goto :ACTION_RESTORE
if "%CHOICE%"=="10" goto :ACTION_REVERT
if "%CHOICE%"=="0"  goto :ACTION_EXIT
if "%CHOICE%"=="00" goto :ACTION_EXIT

echo.
echo  %C_RED%[!] Invalid option. Please choose a number between 0 and 10.%C_RESET%
timeout /t 2 >nul
goto :MAIN_MENU

:: ============================================================================
::  ACTION HANDLERS (WITH CONFIRMATION SAFETY PROMPTS)
:: ============================================================================
:ACTION_ALL
cls
call :BANNER_SECTION "Full System Optimization Pipeline"
echo  This option will perform the following actions:
echo    - Create a System Restore Point checkpoint
echo    - Remove non-essential preinstalled consumer apps
echo    - Disable background telemetry, Copilot, and diagnostic tasks
echo    - Tune CPU core scheduling, power scheme, and system responsiveness
echo    - Optimize TCP/IP network latency and disable Nagle buffering
echo    - Clean temporary files, download cache, and GPU shader caches
echo    - Apply classic responsive context menu and interface refinements
echo.
echo  Essential components (Microsoft Store, Calculator, Notepad) are preserved.
echo.
set /p "CONFIRM_ALL=%C_YELLOW%  Proceed with full system optimization? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_ALL!"=="Y" (
    echo.
    echo  %C_YELLOW%[*] Operation cancelled. No changes were made.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)

echo.
call :DO_RESTORE
call :DO_BLOAT
call :DO_PRIVACY
call :DO_GAMING
call :DO_NETWORK
call :DO_CLEAN
call :DO_VISUALS

echo.
echo %C_GRAY%[=============================================================================]%C_RESET%
echo  %C_GREEN%[+] Full system optimization completed successfully.%C_RESET%
echo  %C_CYAN%[*] A system reboot is recommended to apply kernel and power changes.%C_RESET%
echo %C_GRAY%[=============================================================================]%C_RESET%
echo.
set /p "REBOOT_NOW=%C_YELLOW%  Restart computer now? [Y/N]: %C_RESET%"
if /i "%REBOOT_NOW%"=="Y" (
    echo  %C_CYAN%[*] Restarting computer in 5 seconds...%C_RESET%
    shutdown /r /t 5 /c "libreScript: Restarting to apply system optimizations"
    exit /b 0
)
pause
goto :MAIN_MENU

:ACTION_BLOAT
cls
call :BANNER_SECTION "Remove Preinstalled Bloatware Apps"
echo  This removes sponsored apps, OEM stubs, and non-essential consumer packages.
echo  Microsoft Store, Calculator, Notepad, Camera, and Windows Terminal are kept safe.
echo.
set /p "CONFIRM_BLOAT=%C_YELLOW%  Remove preinstalled bloatware packages? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_BLOAT!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_BLOAT
echo.
echo  %C_GREEN%[+] Bloatware removal completed.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_PRIVACY
cls
call :BANNER_SECTION "Disable Telemetry, Copilot and AI Services"
echo  This disables background telemetry services, scheduled diagnostic tasks,
echo  Windows Copilot, Recall snapshot analysis, and Start Menu web queries.
echo.
set /p "CONFIRM_PRIVACY=%C_YELLOW%  Apply telemetry and privacy adjustments? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_PRIVACY!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_PRIVACY
echo.
echo  %C_GREEN%[+] Telemetry and privacy settings applied.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_GAMING
cls
call :BANNER_SECTION "Performance and System Latency Tuning"
echo  This unparks CPU cores, enables Ultimate Performance power profile,
echo  tunes MMCSS priority, enables HAGS, and disables GameDVR background recording.
echo.
set /p "CONFIRM_GAMING=%C_YELLOW%  Apply performance and latency tuning? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_GAMING!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_GAMING
echo.
echo  %C_GREEN%[+] Performance settings applied. Restart recommended.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_NETWORK
cls
call :BANNER_SECTION "Network Stack and TCP Latency Tuning"
echo  This configures TCPNoDelay (disables Nagle algorithm), enables Receive Side
echo  Scaling (RSS), removes network throttling reserve, and tunes DNS caching.
echo.
set /p "CONFIRM_NET=%C_YELLOW%  Apply network stack optimizations? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_NET!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_NETWORK
echo.
echo  %C_GREEN%[+] Network settings updated successfully.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_CLEAN
cls
call :BANNER_SECTION "Temporary Files and Cache Cleanup"
echo  This cleans temporary folders, prefetch, Windows Update download cache,
echo  crash minidumps, and DirectX/Vulkan GPU shader caches.
echo.
set /p "CONFIRM_CLEAN=%C_YELLOW%  Clean temporary files and caches? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_CLEAN!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_CLEAN
echo.
echo  %C_GREEN%[+] Temporary files and cache cleanup completed.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_VISUALS
cls
call :BANNER_SECTION "Desktop and Interface Adjustments"
echo  This enables the classic Windows 10 style context menu, sets a compact
echo  taskbar search box, eliminates app launch delays, and restarts Explorer.
echo.
set /p "CONFIRM_VIS=%C_YELLOW%  Apply interface adjustments? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_VIS!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_VISUALS
echo.
echo  %C_GREEN%[+] Interface adjustments applied and Explorer refreshed.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_REPAIR
cls
call :BANNER_SECTION "System File Verification and Image Repair"
call :DO_REPAIR
echo.
echo  %C_GREEN%[+] System integrity audit finished.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_RESTORE
cls
call :BANNER_SECTION "Create System Restore Point"
call :DO_RESTORE
pause
goto :MAIN_MENU

:ACTION_REVERT
cls
call :BANNER_SECTION "Restore Default Windows Settings"
echo  This will revert the optimizations applied by libreScript:
echo    - Restore default modern Windows context menu
echo    - Revert telemetry, Copilot, and cloud search policies
echo    - Re-enable diagnostic background services and tasks
echo    - Reset TCP/IP stack to default automatic tuning
echo    - Remove BCD timer tweaks and restore default clock settings
echo    - Restore Balanced power scheme
echo    - Re-enable memory compression and hibernation
echo.
set /p "CONFIRM_REV=%C_YELLOW%  Are you sure you want to restore Windows defaults? [Y/N]: %C_RESET%"
if /i not "!CONFIRM_REV!"=="Y" (
    echo  %C_YELLOW%[*] Operation cancelled. No settings were changed.%C_RESET%
    timeout /t 2 >nul
    goto :MAIN_MENU
)
echo.
call :DO_REVERT
echo.
echo  %C_GREEN%[+] Windows default settings restored successfully.%C_RESET%
pause
goto :MAIN_MENU

:ACTION_EXIT
echo.
echo  %C_CYAN%[*] Exiting libreScript. Have a productive day.%C_RESET%
timeout /t 1 >nul
exit /b 0

:: ============================================================================
::  HEADLESS CLI ROUTINES (AUTOMATION / SCRIPTS)
:: ============================================================================
:CLI_ALL
call :DO_RESTORE
call :DO_BLOAT
call :DO_PRIVACY
call :DO_GAMING
call :DO_NETWORK
call :DO_CLEAN
call :DO_VISUALS
echo [+] libreScript automated optimization finished.
exit /b 0

:CLI_BLOAT
call :DO_BLOAT
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

:CLI_CLEAN
call :DO_CLEAN
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
echo libreScript - Command Line Interface Reference
echo.
echo Usage: libreScript.bat [option]
echo.
echo Options:
echo   /all      Run full optimization unattended (Restore, Bloat, Privacy, Latency, Network, Clean, Visuals)
echo   /bloat    Remove preinstalled non-essential consumer apps while preserving core tools
echo   /privacy  Disable Copilot, Recall, telemetry services, diagnostic tasks, and tracking
echo   /gaming   Unpark CPU cores, switch to Ultimate Performance plan, tune MMCSS, enable HAGS
echo   /network  Configure TCPNoDelay, disable Nagle algorithm, set RSS, unthrottle network index
echo   /clean    Clean user/system temp, prefetch, update download cache, shader caches
echo   /visuals  Restore classic context menu, compact taskbar search, remove app startup delay
echo   /repair   Run DISM /Online /Cleanup-Image /RestoreHealth and SFC /scannow
echo   /restore  Create a manual pre-execution System Restore Point checkpoint
echo   /revert   Restore standard Windows defaults, services, power plan, and context menu
echo   /help     Display this help manual
exit /b 0

:: ============================================================================
::  CORE IMPLEMENTATION SUBROUTINES
:: ============================================================================
:BANNER_SECTION
echo %C_GRAY%[=============================================================================]%C_RESET%
echo  %C_CYAN%libreScript :: %~1%C_RESET%
echo %C_GRAY%[=============================================================================]%C_RESET%
echo.
exit /b 0

:: ----------------------------------------------------------------------------
::  1. SYSTEM RESTORE POINT SNAPSHOT
:: ----------------------------------------------------------------------------
:DO_RESTORE
echo  %C_CYAN%[*] Enabling System Protection on drive C:\...%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\' -ErrorAction SilentlyContinue" >nul 2>&1

echo  %C_CYAN%[*] Configuring System Restore frequency limits...%C_RESET%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Creating restore point 'Before_libreScript_Optimization'...%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference = 'Stop';" ^
    "try {" ^
    "  Checkpoint-Computer -Description 'Before_libreScript_Optimization' -RestorePointType 'MODIFY_SETTINGS';" ^
    "  exit 0" ^
    "} catch {" ^
    "  Write-Host ('    Notice: ' + $_.Exception.Message);" ^
    "  exit 1" ^
    "}"
if %errorlevel% equ 0 (
    echo  %C_GREEN%[+] System Restore Point created successfully.%C_RESET%
) else (
    echo  %C_YELLOW%[!] Notice: Could not create a restore checkpoint.%C_RESET%
    echo  %C_YELLOW%    Verify that System Protection is enabled for drive C:\ in Windows System Properties.%C_RESET%
)
exit /b 0

:: ----------------------------------------------------------------------------
::  2. UWP & CONSUMER BLOATWARE REMOVAL (PRESERVES CORE APPS)
:: ----------------------------------------------------------------------------
:DO_BLOAT
echo  %C_CYAN%[*] Removing non-essential consumer packages...%C_RESET%
echo  %C_GRAY%    (Preserves Microsoft Store, Terminal, Notepad, Calculator, Camera and Snipping Tool)%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$BloatList = @(" ^
    "  'Microsoft.BingNews'," ^
    "  'Microsoft.BingWeather'," ^
    "  'Microsoft.BingFinance'," ^
    "  'Microsoft.BingSports'," ^
    "  'Microsoft.BingSearch'," ^
    "  'Microsoft.GetHelp'," ^
    "  'Microsoft.Getstarted'," ^
    "  'Microsoft.MicrosoftSolitaireCollection'," ^
    "  'Microsoft.People'," ^
    "  'Microsoft.Todos'," ^
    "  'Microsoft.PowerAutomateDesktop'," ^
    "  'Clipchamp.Clipchamp'," ^
    "  'Microsoft.549981C3F5F10'," ^
    "  'Microsoft.WindowsFeedbackHub'," ^
    "  'Microsoft.YourPhone'," ^
    "  'Microsoft.ZuneVideo'," ^
    "  'Microsoft.ZuneMusic'," ^
    "  'Microsoft.MicrosoftOfficeHub'," ^
    "  'Microsoft.Office.OneNote'," ^
    "  'Microsoft.SkypeApp'," ^
    "  'SpotifyAB.SpotifyMusic'," ^
    "  'Disney.37853FC2267DE'," ^
    "  'BytedancePte.Ltd.TikTok'," ^
    "  '4DF9E0F8.Netflix'," ^
    "  'Facebook.Facebook'," ^
    "  'Facebook.InstagramBeta'," ^
    "  'LinkedIn.LinkedIn'" ^
    ");" ^
    "foreach ($app in $BloatList) {" ^
    "  Get-AppxPackage -AllUsers -Name ('*' + $app + '*') -ErrorAction SilentlyContinue | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue;" ^
    "  Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -like ('*' + $app + '*') } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue;" ^
    "}" >nul 2>&1
echo  %C_GREEN%[+] Selected consumer bloatware packages removed.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  3. TELEMETRY, PRIVACY & AI CONFIGURATION
:: ----------------------------------------------------------------------------
:DO_PRIVACY
echo  %C_CYAN%[*] Disabling Windows Recall and AI screen analysis...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "AllowScreenAnalysis" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v "AllowScreenAnalysis" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling Windows Copilot...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling Cortana and Bing cloud search queries in Start Menu...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Restricting Diagnostic Data and feedback notifications...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableEnterpriseAuthProxy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "CommercialDataOptIn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling background diagnostic services...%C_RESET%
sc config DiagTrack start=disabled >nul 2>&1
net stop DiagTrack >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
net stop dmwappushservice >nul 2>&1
sc config diagnosticshub.standardcollector.service start=disabled >nul 2>&1
net stop diagnosticshub.standardcollector.service >nul 2>&1
sc config MapsBroker start=disabled >nul 2>&1
net stop MapsBroker >nul 2>&1
sc config RetailDemo start=disabled >nul 2>&1
net stop RetailDemo >nul 2>&1
sc config WerSvc start=disabled >nul 2>&1
net stop WerSvc >nul 2>&1

echo  %C_CYAN%[*] Disabling scheduled diagnostic collection tasks...%C_RESET%
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable >nul 2>&1

echo  %C_CYAN%[*] Disabling advertising ID and promotional suggestions...%C_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling activity history tracking...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling typing telemetry and location tracking...%C_RESET%
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1
sc config lfsvc start=disabled >nul 2>&1
net stop lfsvc >nul 2>&1

echo  %C_CYAN%[*] Disabling background browser metrics in Microsoft Edge...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f >nul 2>&1

echo  %C_CYAN%[*] Preventing forced automatic restarts during active sessions...%C_RESET%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
echo  %C_GREEN%[+] Telemetry and privacy settings applied.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  4. PERFORMANCE, POWER & LATENCY CONFIGURATION
:: ----------------------------------------------------------------------------
:DO_GAMING
echo  %C_CYAN%[*] Unparking CPU cores for full availability...%C_RESET%
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c362-4b78-8104-630237a18c08 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 0cc5b647-c362-4b78-8104-630237a18c08 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor CPMINCORES 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor CPMAXCORES 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor CPMAXCORES 100 >nul 2>&1
powercfg -setactive scheme_current >nul 2>&1

echo  %C_CYAN%[*] Disabling CPU power throttling...%C_RESET%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1

echo  %C_CYAN%[*] Configuring Ultimate Performance power plan...%C_RESET%
set "UP_GUID="
for /f "tokens=4" %%a in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul') do (
    set "UP_GUID=%%a"
)
if defined UP_GUID (
    powercfg -setactive !UP_GUID! >nul 2>&1
    echo  %C_GREEN%[+] Activated Ultimate Performance profile (!UP_GUID!).%C_RESET%
) else (
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    echo  %C_GREEN%[+] Activated High Performance profile.%C_RESET%
)

echo  %C_CYAN%[*] Adjusting hardware system timer (IRQ8) priority...%C_RESET%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling dynamic tick and platform clock jitter...%C_RESET%
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set useplatformclock no >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1

echo  %C_CYAN%[*] Enabling Hardware-Accelerated GPU Scheduling (HAGS)...%C_RESET%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1

echo  %C_CYAN%[*] Tuning MMCSS gaming priority and responsiveness reserve...%C_RESET%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1

echo  %C_CYAN%[*] Disabling GameDVR background encoding overhead...%C_RESET%
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling memory compression latency overhead...%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-MMAgent -mc" >nul 2>&1

echo  %C_CYAN%[*] Disabling hibernation and hybrid fast startup file overhead...%C_RESET%
powercfg -h off >nul 2>&1
echo  %C_GREEN%[+] Performance and latency optimizations deployed.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  5. NETWORK STACK & TCP/IP LATENCY TUNING
:: ----------------------------------------------------------------------------
:DO_NETWORK
echo  %C_CYAN%[*] Disabling NTFS 8.3 name creation and access timestamps...%C_RESET%
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1

echo  %C_CYAN%[*] Removing network throttling bandwidth ceiling...%C_RESET%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1

echo  %C_CYAN%[*] Tuning TCP/IP parameters (RSS, autotuning, timestamps)...%C_RESET%
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set global rsc=enabled >nul 2>&1

echo  %C_CYAN%[*] Configuring TCPNoDelay and TcpAckFrequency (Nagle Algorithm disable)...%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces';" ^
    "Get-ChildItem $path | ForEach-Object {" ^
    "  New-ItemProperty -Path $_.PSPath -Name 'TcpAckFrequency' -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null;" ^
    "  New-ItemProperty -Path $_.PSPath -Name 'TCPNoDelay' -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null;" ^
    "  New-ItemProperty -Path $_.PSPath -Name 'TcpDelAckTicks' -Value 0 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null;" ^
    "}" >nul 2>&1

echo  %C_CYAN%[*] Tuning DNS client cache lookup parameters...%C_RESET%
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl" /t REG_DWORD /d 86400 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxNegativeCacheTtl" /t REG_DWORD /d 5 /f >nul 2>&1
echo  %C_GREEN%[+] Network and file system settings applied.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  6. TEMPORARY FILES, UPDATE DOWNLOADS & SHADER CACHE CLEANUP
:: ----------------------------------------------------------------------------
:DO_CLEAN
echo  %C_CYAN%[*] Stopping background caching services safely...%C_RESET%
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop sysmain >nul 2>&1
net stop dosvc >nul 2>&1

echo  %C_CYAN%[*] Cleaning temporary folders...%C_RESET%
if defined TEMP if exist "%TEMP%" (
    del /f /s /q "%TEMP%\*.*" >nul 2>&1
    for /d %%p in ("%TEMP%\*") do rmdir /s /q "%%p" >nul 2>&1
)
if defined SYSTEMROOT if exist "%SYSTEMROOT%\Temp" (
    del /f /s /q "%SYSTEMROOT%\Temp\*.*" >nul 2>&1
    for /d %%p in ("%SYSTEMROOT%\Temp\*") do rmdir /s /q "%%p" >nul 2>&1
)
if defined SYSTEMROOT if exist "%SYSTEMROOT%\Prefetch" (
    del /f /s /q "%SYSTEMROOT%\Prefetch\*.*" >nul 2>&1
)
if defined SYSTEMROOT if exist "%SYSTEMROOT%\SoftwareDistribution\Download" (
    del /f /s /q "%SYSTEMROOT%\SoftwareDistribution\Download\*.*" >nul 2>&1
    for /d %%p in ("%SYSTEMROOT%\SoftwareDistribution\Download\*") do rmdir /s /q "%%p" >nul 2>&1
)

echo  %C_CYAN%[*] Cleaning GPU and DirectX shader caches...%C_RESET%
if defined LOCALAPPDATA (
    if exist "%LOCALAPPDATA%\D3DSCache" del /f /s /q "%LOCALAPPDATA%\D3DSCache\*.*" >nul 2>&1
    if exist "%LOCALAPPDATA%\NVIDIA\DXCache" del /f /s /q "%LOCALAPPDATA%\NVIDIA\DXCache\*.*" >nul 2>&1
    if exist "%LOCALAPPDATA%\NVIDIA\GLCache" del /f /s /q "%LOCALAPPDATA%\NVIDIA\GLCache\*.*" >nul 2>&1
    if exist "%LOCALAPPDATA%\AMD\DxCache" del /f /s /q "%LOCALAPPDATA%\AMD\DxCache\*.*" >nul 2>&1
    if exist "%LOCALAPPDATA%\Intel\ShaderCache" del /f /s /q "%LOCALAPPDATA%\Intel\ShaderCache\*.*" >nul 2>&1
)

echo  %C_CYAN%[*] Cleaning thumbnail caches and crash dumps...%C_RESET%
if defined LOCALAPPDATA (
    if exist "%LOCALAPPDATA%\IconCache.db" del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
    if exist "%LOCALAPPDATA%\Microsoft\Windows\Explorer" (
        del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
        del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache_*.db" >nul 2>&1
    )
    if exist "%LOCALAPPDATA%\CrashDumps" del /f /s /q "%LOCALAPPDATA%\CrashDumps\*.*" >nul 2>&1
)
if defined SYSTEMROOT if exist "%SYSTEMROOT%\Minidump" (
    del /f /s /q "%SYSTEMROOT%\Minidump\*.*" >nul 2>&1
)
if defined PROGRAMDATA if exist "%PROGRAMDATA%\Microsoft\Windows\WER" (
    del /f /s /q "%PROGRAMDATA%\Microsoft\Windows\WER\ReportQueue\*.*" >nul 2>&1
    del /f /s /q "%PROGRAMDATA%\Microsoft\Windows\WER\ReportArchive\*.*" >nul 2>&1
)

echo  %C_CYAN%[*] Cleaning Delivery Optimization cache...%C_RESET%
if defined SYSTEMROOT if exist "%SYSTEMROOT%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache" (
    del /f /s /q "%SYSTEMROOT%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*.*" >nul 2>&1
)

echo  %C_CYAN%[*] Restarting essential background services...%C_RESET%
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
net start sysmain >nul 2>&1
net start dosvc >nul 2>&1
echo  %C_GREEN%[+] Temporary files and cache cleaning completed.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  7. DESKTOP & EXPLORER INTERFACE ADJUSTMENTS
:: ----------------------------------------------------------------------------
:DO_VISUALS
echo  %C_CYAN%[*] Restoring classic responsive Windows context menu...%C_RESET%
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f >nul 2>&1

echo  %C_CYAN%[*] Configuring compact search icon on taskbar...%C_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>&1

echo  %C_CYAN%[*] Removing application startup delay...%C_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Disabling Taskbar Widgets and news feeds...%C_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f >nul 2>&1

echo  %C_CYAN%[*] Refreshing Windows Explorer shell...%C_RESET%
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe >nul 2>&1
echo  %C_GREEN%[+] Interface adjustments applied.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  8. SYSTEM INTEGRITY VERIFICATION (DISM & SFC)
:: ----------------------------------------------------------------------------
:DO_REPAIR
echo  %C_CYAN%[*] Starting Windows Component Store repair scan (DISM)...%C_RESET%
echo  %C_GRAY%    (This operation checks and repairs system image health. Please wait.)%C_RESET%
DISM.exe /Online /Cleanup-Image /RestoreHealth
echo.
echo  %C_CYAN%[*] Starting System File Checker scan (SFC)...%C_RESET%
sfc /scannow
echo  %C_GREEN%[+] System integrity audit finished.%C_RESET%
exit /b 0

:: ----------------------------------------------------------------------------
::  9. ROLLBACK TO DEFAULTS (COMPLETE & VERIFIED REVERSION)
:: ----------------------------------------------------------------------------
:DO_REVERT
echo  %C_CYAN%[*] Restoring default modern context menu...%C_RESET%
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1

echo  %C_CYAN%[*] Restoring default taskbar search box and startup delay...%C_RESET%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /f >nul 2>&1

echo  %C_CYAN%[*] Restoring taskbar widgets and news feeds...%C_RESET%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /f >nul 2>&1

echo  %C_CYAN%[*] Restoring telemetry and AI policies to defaults...%C_RESET%
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 1 /f >nul 2>&1

echo  %C_CYAN%[*] Restoring Start Menu search and Cortana policies...%C_RESET%
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 1 /f >nul 2>&1

echo  %C_CYAN%[*] Restoring advertising, cloud content, and activity tracking policies...%C_RESET%
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\InputPersonalization" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /f >nul 2>&1

echo  %C_CYAN%[*] Restoring background diagnostic services...%C_RESET%
sc config DiagTrack start=auto >nul 2>&1
net start DiagTrack >nul 2>&1
sc config dmwappushservice start=demand >nul 2>&1
sc config diagnosticshub.standardcollector.service start=demand >nul 2>&1
sc config MapsBroker start=auto >nul 2>&1
sc config RetailDemo start=demand >nul 2>&1
sc config WerSvc start=demand >nul 2>&1
sc config lfsvc start=demand >nul 2>&1

echo  %C_CYAN%[*] Re-enabling scheduled diagnostic tasks...%C_RESET%
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /enable >nul 2>&1

echo  %C_CYAN%[*] Restoring power throttling, timer, and scheduling parameters...%C_RESET%
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue tscsyncpolicy >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /f >nul 2>&1

echo  %C_CYAN%[*] Restoring multimedia responsiveness and GameDVR settings...%C_RESET%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 20 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /f >nul 2>&1

echo  %C_CYAN%[*] Re-enabling memory compression and hibernation...%C_RESET%
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-MMAgent -mc" >nul 2>&1
powercfg -h on >nul 2>&1

echo  %C_CYAN%[*] Restoring default Balanced power scheme...%C_RESET%
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1

echo  %C_CYAN%[*] Resetting TCP/IP stack and removing interface overrides...%C_RESET%
fsutil behavior set disable8dot3 0 >nul 2>&1
fsutil behavior set disablelastaccess 0 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f >nul 2>&1
netsh int ip reset >nul 2>&1
netsh int tcp reset >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global timestamps=allowed >nul 2>&1
netsh int tcp set global rss=default >nul 2>&1
netsh int tcp set heuristics enabled >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces';" ^
    "Get-ChildItem $path | ForEach-Object {" ^
    "  Remove-ItemProperty -Path $_.PSPath -Name 'TcpAckFrequency' -ErrorAction SilentlyContinue | Out-Null;" ^
    "  Remove-ItemProperty -Path $_.PSPath -Name 'TCPNoDelay' -ErrorAction SilentlyContinue | Out-Null;" ^
    "  Remove-ItemProperty -Path $_.PSPath -Name 'TcpDelAckTicks' -ErrorAction SilentlyContinue | Out-Null;" ^
    "}" >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxNegativeCacheTtl" /f >nul 2>&1

echo  %C_CYAN%[*] Refreshing Windows Explorer shell...%C_RESET%
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe >nul 2>&1
echo  %C_GREEN%[+] System defaults rolled back successfully.%C_RESET%
exit /b 0
