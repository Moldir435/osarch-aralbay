# Lab 2 — A Windows guest, and a network between them

Pair:None                     Driver first half:Moldir
Machine:Huawei
Date:25.10.2026

## What I did

1.Deployed a Windows 11 Enterprise evaluation VM alongside the existing Ubuntu in VMware Workstation.
2.Configured both virtual machines to use NAT mode (VMnet8) to ensure cross-VM communication while preventing packet drops from campus MAC filtering.

```
markdown

⁠```bash
# On Linux (check IP and ping Windows):
ip addr
ping -c 4 192.168.219.132
# 4 packets transmitted, 4 received, 0% packet loss

⁠```cmd
:: On Windows (check IP, open ICMP in firewall, ping Linux):
ipconfig
powershell -Command "New-NetFirewallRule -DisplayName 'Allow ICMPv4-In' -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow"
ping 192.168.219.131
:: Packets: Sent = 4, Received = 4, Lost = 0 (0% loss)
```

## Result
Both VMs successfully communicate bidirectionally and have internet access via NAT mode. The ICMP traffic is handled cleanly through a dedicated firewall rule without exposing the guest system. The memory overcommitment test was measured and documented.

## What did not work the first time

Initial pings from Ubuntu to Windows 11 timed out (100% packet loss).
Cause: By default, the Windows Defender Firewall drops incoming ICMPv4 echo requests on public/private profiles.
Fix: Rather than disabling the firewall completely, an inbound rule was added via PowerShell targeting only ICMPv4 type 8 packets, which immediately restored connectivity.

## Evidence

- ⁠`evidence/host-memory-before.png⁠` — Host RAM usage before launching and overcommitting VMs.
- ⁠`evidence/host-memory-after.png⁠`— Host RAM usage under memory overcommitment load.
- ⁠`evidence/ipconfig-windows.txt⁠` — Network interface details from Windows 11 guest. 
- ⁠`evidence/ip-addr-linux.txt⁠` — Network interface details from from Ubuntu Linux guest. 
- ⁠`evidence/ping-both-ways.txt⁠` — Verified ping outputs proving connectivity in both directions.
