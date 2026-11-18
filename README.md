# libreScript

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)
[![Platform: Windows 11 & 10](https://img.shields.io/badge/Platform-Windows%2011%20%7C%2010-0078D6?style=for-the-badge&logo=windows)](https://github.com/PolskieWin/libreScript)
[![Script: Native Batch](https://img.shields.io/badge/Language-Native%20Batch%20%2F%20CMD-4EAA25?style=for-the-badge&logo=gnubash)](libreScript.bat)
[![Ecosystem: Libre](https://img.shields.io/badge/Ecosystem-Libre-orange?style=for-the-badge)](https://github.com/PolskieWin)

**Windows Optimization, Debloat, and Latency Tuning Utility for Windows 11 and 10.**  
*100% Native Batch and PowerShell. Zero Third-Party Binaries. Fully Auditable and Reversible.*

</div>

---

## Overview

Many Windows optimization scripts rely on closed-source executables, obscure binary blobs, or indiscriminately rip out system packages that break Windows Update, the Microsoft Store, or built-in tools.

**libreScript** provides targeted debloating and latency reduction while preserving system stability:
- **Zero Third-Party Binaries:** No external executables or DLLs. Uses built-in Windows administrative utilities (`reg`, `powercfg`, `fsutil`, `bcdedit`, `netsh`, `dism`, `sfc`).
- **Safe Bloatware Removal:** Cleans preinstalled consumer bloat, AI screen analysis, and sponsored apps without breaking the Microsoft Store, Calculator, Notepad, Snipping Tool, Camera, or Windows Terminal.
- **Auditable Plaintext:** Every single change can be reviewed directly in [`libreScript.bat`](libreScript.bat).
- **Safety First:** Includes interactive confirmation prompts, automated System Restore checkpoints, and a comprehensive rollback function to restore Windows defaults.

---

## Quick Run

Run from **Command Prompt (Admin)** or **Windows Terminal (Admin)**:

```cmd
curl.exe -sSL https://raw.githubusercontent.com/PolskieWin/libreScript/main/libreScript.bat -o "%TEMP%\libreScript.bat" && "%TEMP%\libreScript.bat"
```

Or via **PowerShell (Admin)**:

```powershell
irm https://raw.githubusercontent.com/PolskieWin/libreScript/main/libreScript.bat -OutFile "$env:TEMP\libreScript.bat"; & "$env:TEMP\libreScript.bat"
```

Or clone and run locally:

```cmd
git clone https://github.com/PolskieWin/libreScript.git
cd libreScript
libreScript.bat
```

---

## Interactive Menu

When launched without arguments, `libreScript` opens an interactive menu:

```text
  _ _ _               ____            _       _   
 | (_) |__  _ __ ___ / ___|  ___ _ __(_)_ __ | |_ 
 | | | '_ \| '__/ _ \\___ \ / __| '__| | '_ \| __|
 | | | |_) | | |  __/ ___) | (__| |  | | |_) | |_ 
 |_|_|_.__/|_|  \___||____/ \___|_|  |_| .__/ \__|
                                        |_|        

[=============================================================================]
 [*] Utility     : libreScript - Clean Windows Optimization Framework
 [*] Privilege   : Administrator Elevated
 [*] Platform    : Windows [AMD64] :: 10.0.22631
 [*] Safety      : Safe guardrails active (Microsoft Store & system tools kept)
[=============================================================================]

  [01] Full System Optimization   -- Restore point, bloatware, telemetry, latency, clean
  [02] Remove Bloatware Apps      -- Safe removal of preinstalled consumer apps (keeps Store)
  [03] Disable Telemetry & AI     -- Turn off Copilot, Recall, and diagnostic tracking
  [04] Performance & Latency      -- CPU unparking, timer priority, power scheme, GameDVR
  [05] Network Stack Tuning       -- TCPNoDelay, Receive Side Scaling, DNS cache optimization
  [06] Clean Temporary Files      -- Clear user temp, prefetch, shader caches, and update logs
  [07] Interface Adjustments      -- Restore classic context menu, clean search bar, zero delay
  [08] System File Verification   -- Run DISM image repair and SFC integrity scan
  [09] Create Restore Point       -- Generate a manual System Restore checkpoint
  [10] Restore Default Settings   -- Revert applied optimizations back to Windows defaults
  [00] Exit                       -- Close libreScript

[=============================================================================]
  Select an option [0-10]: 
```

---

## Optimization Modules

| Module | Core Actions Taken | Safety Guardrails |
| :--- | :--- | :--- |
| **System Restore Point** | Ensures System Protection is active and generates a `Before_libreScript_Optimization` checkpoint. | Validates restore point status and reports if protection is disabled. |
| **Bloatware Removal** | Removes sponsored apps (Spotify, Disney, Netflix, TikTok) and non-essential consumer packages (Bing News/Weather/Finance, Solitaire, Tips, Feedback Hub). | Strictly preserves Microsoft Store, Windows Terminal, Notepad, Calculator, Camera, and Snipping Tool. |
| **Telemetry & Privacy** | Disables Windows Recall screen analysis, Windows Copilot, diagnostic telemetry services (`DiagTrack`, `dmwappushservice`), scheduled diagnostic tasks, and Start Menu web queries. | Windows Update remains functional for critical patches; prevents forced restarts during active user sessions. |
| **Performance & Latency** | Unparks CPU cores, activates genuine Ultimate Performance power scheme, elevates IRQ8 System Timer priority, disables dynamic tick jitter, enables HAGS, and disables GameDVR background recording. | Preserves hardware thermal management; does not alter hardware voltages. |
| **Network & File System** | Eliminates NTFS 8.3 legacy name creation and disk access timestamps, removes network throttling index cap, enables RSS, and applies `TCPNoDelay` to disable Nagle packet buffering delays. | Retains standard TCP auto-tuning; avoids interfering with VPNs or network adapters. |
| **Temporary Files & Cache** | Safely pauses caching services, cleans user/system `%TEMP%`, Prefetch, Windows Update download cache, DirectX/Vulkan shader caches, crash minidumps, and thumbnail databases, then cleanly restarts services. | Checks environment variables before deletion; avoids touching active drivers or personal files. |
| **Interface Adjustments** | Restores the classic responsive context menu on Windows 11, sets a compact taskbar search box, disables taskbar widgets/news feeds, and eliminates Explorer startup delay. | Refreshes the Explorer shell cleanly without requiring a system reboot. |
| **System File Verification** | Runs component store repair using `DISM /Cleanup-Image /RestoreHealth` followed by `sfc /scannow`. | Relies entirely on official Microsoft maintenance tools. |
| **Restore Default Settings** | Restores default modern context menu, reverts telemetry and Copilot policies, re-enables diagnostic services and tasks, restores Balanced power scheme, re-enables memory compression, and resets TCP/IP stack. | Comprehensive, single-step rollback for all applied optimizations. |

---

## Command-Line Arguments (Headless Mode)

For unattended deployment, image customization, or clean installs:

| Flag | Function |
| :--- | :--- |
| `libreScript.bat /all` | Run full optimization pipeline unattended (Restore, Bloat, Privacy, Latency, Network, Clean, Visuals). |
| `libreScript.bat /bloat` | Remove preinstalled consumer bloatware packages only. |
| `libreScript.bat /privacy` | Disable Copilot, Recall, telemetry services, diagnostic tasks, and tracking. |
| `libreScript.bat /gaming` | Apply CPU core unparking, GPU HAGS, power scheme, timer, and GameDVR tweaks. |
| `libreScript.bat /network` | Apply TCPNoDelay, RSS, and file system latency adjustments. |
| `libreScript.bat /clean` | Clean temporary folders, prefetch, shader caches, and update installers. |
| `libreScript.bat /visuals` | Restore classic context menu, compact search, and eliminate app launch delays. |
| `libreScript.bat /repair` | Run DISM image repair and SFC integrity scan. |
| `libreScript.bat /restore` | Create a standalone System Restore checkpoint. |
| `libreScript.bat /revert` | Restore standard Windows settings, diagnostic services, power plan, and context menu. |
| `libreScript.bat /help` | Display command-line reference. |

---

## Safety and Disclaimer

Low-level registry, power configuration, and system service modifications should always be preceded by an up-to-date backup. Please review [TERMS.md](TERMS.md) before use.

---

## License

Distributed under the **MIT License**. See [LICENSE](LICENSE) for details.  
Part of the **[Libre Open-Source Ecosystem](https://github.com/PolskieWin)**.
