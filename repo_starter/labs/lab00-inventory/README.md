# Lab 0 — Inventory your own machine

Pair:   none                  Driver first half:Moldir
Machine:Huawei
Date:10.10.2026

## What I did

```
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, 
NumberOfLogicalProcessors 
Output saved to evidence/cpu.txt
```

```
Get-CimInstance Win32_PhysicalMemory | Select-Object BankLabel, Capacity,
Speed
Output saved to evidence/memory.txt
```

```
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, BusType, Size
Get-Volume -DriveLetter C
Output saved to evidence/disk.txt
```

```
Get-CimInstance Win32_BIOS | Select-Object SMBIOSBIOSVersion, ReleaseDate
(Get-ComputerInfo).BiosFirmwareType
Output saved to evidence/
```

```
systeminfo | Select-String "Virtualization","hypervisor"
Output saved to evidence/
```

## Result

| What | Value | Where I got it |
|------|-------|----------------|
| CPU model | 12th Gen Intel(R) Core(TM) i5-12450H | `Get-CimInstance Win32_Processor` |
| Cores / threads | 8 / 12 | `Get-CimInstance Win32_Processor` |
| Total RAM | 16 GB | `Get-CimInstance Win32_PhysicalMemory` |
| RAM modules / speed | 8 / 3200 MHz | `Get-CimInstance
Win32_PhysicalMemory` |
| Disk model | WD PC SN740 SDDPNQD-512G-1127 | `Get-PhysicalDisk` |
| Disk type | NVMe SSD | `Get-PhysicalDisk` (BusType,
MediaType) |
| Free space (VM volume) | 433 GB | `Get-Volume -DriveLetter C` |
| Firmware type | UEFI | `(Get-ComputerInfo).BiosFirmwareType` |
| Firmware version / date | Latest | `Get-CimInstance Win32_BIOS` |
| Virtualization | Enabled | `systeminfo` |

## What did not work the first time

I had trouble navigating to the correct path in Powershell, but I resolved it by checking the directory structure.

## Evidence

- [evidence/cpu.txt](evidence/cpu.txt) - CPU model, cores, threads
- [evidence/memory.txt](evidence/memory.txt) - RAM size, modules, speed
- [evidence/disk.txt](evidence/disk.txt) - disk model, type, free space
