# ⚡ libreScript

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)
[![Platform: Windows 11 & 10](https://img.shields.io/badge/Platform-Windows%2011%20%7C%2010-0078D6?style=for-the-badge&logo=windows)](https://github.com/PolskieWin/libreScript)
[![Script: 100% Native Batch](https://img.shields.io/badge/Language-Native%20Batch%20%2F%20CMD-4EAA25?style=for-the-badge&logo=gnubash)](libreScript.bat)
[![Ecosystem: Libre](https://img.shields.io/badge/Ecosystem-Libre-orange?style=for-the-badge)](https://github.com/PolskieWin)

**Zero-Bloat, High-Performance Windows 11 & 10 Nuclear Purge & Latency Optimization Engine.**  
*100% Native Batch & PowerShell Commands. Zero Third-Party Binaries. Transparent & Reversible.*

</div>

---

## 💡 Overview

Most Windows optimization suites ship closed-source `.exe` utilities, unpack unknown DLLs, or break system update pipelines irreparably.

**libreScript** is built on the [Libre](https://github.com/PolskieWin) ethos:
- **100% Auditable Plaintext:** Every single change is inspectable right inside [`libreScript.bat`](libreScript.bat).
- **Zero Third-Party Binaries:** No external `.exe` or `.dll` tools. Uses solely built-in Windows administrative utilities (`reg`, `powercfg`, `fsutil`, `bcdedit`, `netsh`, `dism`, `sfc`).
- **Self-Elevating:** Double-click or run from any terminal—it automatically triggers a UAC elevation prompt if not already running as Administrator.
- **Safety-First Architecture:** Integrates automatic System Restore Point creation prior to applying system changes, plus an integrated one-click Revert mode.

---

## 🚀 Quick Run (One-Liner)

Open **Terminal (Admin)** or **Command Prompt (Admin)** and execute:

```cmd
curl.exe -sSL https://raw.githubusercontent.com/PolskieWin/libreScript/main/libreScript.bat -o "%TEMP%\libreScript.bat" && "%TEMP%\libreScript.bat"
```

Or via **PowerShell (Admin)**:

```powershell
irm https://raw.githubusercontent.com/PolskieWin/libreScript/main/libreScript.bat -OutFile "$env:TEMP\libreScript.bat"; & "$env:TEMP\libreScript.bat"
```

*Alternatively, clone the repository and double-click `libreScript.bat`:*
```cmd
git clone https://github.com/PolskieWin/libreScript.git
cd libreScript
libreScript.bat
```

---

## 🎛️ Interactive Menu & Modules

When run without arguments, `libreScript` boots an interactive terminal console:

```text
============================================================================
  _ _ _               ____            _       _   
 | (_) |__  _ __ ___ / ___|  ___ _ __(_)_ __ | |_ 
 | | | '_ \| '__/ _ \\___ \ / __| '__| | '_ \| __|
 | | | |_) | | |  __/ ___) | (__| |  | | |_) | |_ 
 |_|_|_.__/|_|  \___||____/ \___|_|  |_| .__/ \__|
                                       |_|        
  Universal Windows 11 & 10 Nuclear Purge & Latency Optimization Engine
============================================================================

  [1] COMPLETE NUCLEAR PURGE (Recommended: Restore + Clean + Debloat + Game)
  [2] Deep Cache & Slop Purge (Temp, Prefetch, SoftwareDist, Shaders)
  [3] AI, Copilot, Recall & Telemetry Neutralization
  [4] Gaming, Kernel & Hardware Latency Tweaks (HAGS, IRQ8, Power, CPU)
  [5] Network Stack & File System Latency Optimization
  [6] Windows 11 QoL & Visual Tweaks (Classic Context Menu, Clean Search)
  [7] System Integrity Deep Scan (DISM /RestoreHealth + SFC /ScanNow)
  [8] Create System Restore Point (Standalone Safety Checkpoint)
  [9] Revert Core Tweaks to Windows Defaults
  [0] Exit
```

---

## ⚙️ What libreScript Optimizes

| Category | Actions Taken |
| :--- | :--- |
| **🛡️ Safety Net** | Unlocks 24h restore limit and generates `Before_libreScript_Purge` System Restore Point automatically. |
| **🧹 Cache & Slop Purge** | Cleans user/system `%TEMP%`, Windows Prefetch, `SoftwareDistribution\Download`, DirectX shader caches (`D3DSCache`, NVIDIA/AMD `DXCache`), crash minidumps, and thumbnail caches. Restarts update background services cleanly. |
| **🤖 AI & Privacy Debloat** | Completely disables Windows Recall data analysis, Windows Copilot (`HKLM` & `HKCU`), Start Menu Bing queries, Cortana, advertising telemetry, and terminates background tracking services (`DiagTrack`, `dmwappushservice`). Prevents forced automatic reboots during active gaming sessions. |
| **🎮 Hardware & Gaming Latency** | Unparks all CPU cores (`CPMINCORES 100`), duplicates and activates the genuine **Ultimate Performance** power profile, shifts IRQ8 (System Timer) to High Priority, disables dynamic tick (`disabledynamictick yes`), enables Hardware-Accelerated GPU Scheduling (HAGS), and tunes MMCSS gaming scheduling priority. |
| **🌐 Network & File System** | Disables NTFS 8.3 legacy short-name generation, eliminates unnecessary NTFS last-access file timestamps, unthrottles multimedia network index (`NetworkThrottlingIndex = 0xFFFFFFFF`), enables TCP Receive Side Scaling (RSS), and applies `TCPNoDelay` / `TcpAckFrequency` optimization across network adapters. |
| **🖥️ Windows 11 QoL** | Restores the responsive Windows 10 classic context menu on Windows 11, switches to minimal taskbar search icon, eliminates application launch startup delays, and seamlessly refreshes the Windows Explorer shell. |
| **🔧 Health Verification** | Runs automated component store health checks via `DISM /Cleanup-Image /RestoreHealth` and `sfc /scannow`. |
| **↩️ Safe Revert** | Restores default balanced power plan, re-enables standard telemetry services, resets TCP stack parameters, and restores modern context menus. |

---

## 🤖 Command-Line Flags (Unattended Mode)

Integrate `libreScript` directly into automated installations, clean-install deployment scripts, or task sequences:

| Flag | Description |
| :--- | :--- |
| `libreScript.bat /all` | Runs complete nuclear purge unattended (Restore, Clean, Privacy, Gaming, Network, Visuals). |
| `libreScript.bat /clean` | Executes deep cache, temp, and shader purge only. |
| `libreScript.bat /privacy` | Applies AI, Recall, Copilot, and telemetry debloat only. |
| `libreScript.bat /gaming` | Applies CPU unparking, GPU HAGS, power scheme, and timer tweaks only. |
| `libreScript.bat /network` | Applies TCP stack, latency, and NTFS performance tweaks only. |
| `libreScript.bat /visuals` | Applies classic context menu and clean taskbar layout. |
| `libreScript.bat /repair` | Executes DISM Online Image Repair and SFC Scannow. |
| `libreScript.bat /restore` | Creates a standalone System Restore checkpoint. |
| `libreScript.bat /revert` | Restores default Windows settings and services. |
| `libreScript.bat /help` | Displays command-line reference. |

---

## ⚖️ Safety & Disclaimer

Low-level registry and kernel scheduling adjustments should always be paired with a reliable safety net. Please review our [TERMS.md](TERMS.md) before execution.

---

## 📄 License

Distributed under the **MIT License**. See [LICENSE](LICENSE) for details.
Part of the **[Libre Open-Source Ecosystem](https://github.com/PolskieWin)**.
