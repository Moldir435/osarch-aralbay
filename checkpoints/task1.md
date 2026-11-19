## 1a
| Figure | This computer |Command it came from |
|--------|---------------|---------------------|
| CPU model | Intel(R) Core(TM) i5-12450H | Get-CimInstance Win32_Processor |
| Cores/logical processors | 5 | Select-Object NumberOfCores |
| Hardware virtualization: supported? enabled in firmware? | yes | Get-CimInstance Win32_ComputerSystem |
| Memory: total / available now | total: 15,73  available: 10,62 | Get-CimInstance Win32_OperatingSystem |
| System disk: size, free space, SSD or HDD | WD PC SN740 SSD | Get-PhysicalDisk |
| Partition style of the system disk | GPT | Get-Disk |
| OS and version | 10.0.26100 |  Get-CimInstance Win32_OperatingSystem |

##1b
| Part | Specification |
|------|---------------|
| CPU | 5 cores |
| Memory | 10,4 GB
| Storage | 23,5 GB |
| OS | Windows 11 Home in S mode |