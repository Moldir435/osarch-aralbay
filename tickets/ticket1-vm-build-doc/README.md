# Ticket 1 — Test machine for new dev

## 1. What was asked
> From: Aigerim T. (Office Manager)
> Subject: test machine for new dev
> 
> Hi, we have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself? Thanks

## 2. What was actually needed
The request is extremely vague and written from a non-technical perspective:
- **Missing details:** It omits target OS requirements (distribution, kernel), host resource availability, exact hardware sizing (vCPU, RAM, storage), and network isolation criteria.
- **Where the request is wrong:** The requester asked for "a test computer", implying a single physical machine. In real-world software testing, bare metal exposes corporate hardware to configuration drift and data loss. A virtualized environment with snapshot capabilities is required so the engineer can run experiments and roll back immediately. Furthermore, cross-platform validation often requires both Linux and Windows environments.
- **What I would have asked the requester:**
  1. What tech stack and dependencies will the developer run (Docker, .NET, Node.js)?
  2. Does the test machine require corporate domain access or strictly isolated sandbox networking?
  3. What are the host machine specifications?
- **Assumptions made:**
  1. Host machine has 16 GB RAM and sufficient multi-core CPU capacity.
  2. The developer needs an Ubuntu Server environment (`lab01`) for backend workloads alongside a secondary Windows 11 guest for client-side testing.
  3. Guests must share an internal isolated subnet with outbound Internet access via NAT.

## 3. What I did

### Resource Allocation Calculations
Host specs: 16 GB RAM, multi-core CPU, SSD storage.
- **Linux VM (`lab01` - Ubuntu Server):**
  - RAM: 2048 MB (2 GB).
  - CPU: 2 vCPUs.
  - Disk: 20 GB SCSI virtual disk (`.vmdk`).
- **Windows 11 Guest:**
  - Standard development sandbox allocation on the same virtual network.
- *Host reservation:* Over 10 GB of RAM remains unallocated, preserving host responsiveness and stability.

### Non-Default Settings & Justifications
1. **Hypervisor Engine:** Deployed on VMware Workstation for robust hardware virtualization and unified snapshot handling.
2. **Storage Architecture:** Single 20 GB SCSI virtual disk allocated dynamically, optimizing local host storage consumption while maintaining adequate capacity for OS binaries and build artifacts.
3. **Network Mode (VMware NAT):** Configured a single virtual network adapter set to NAT. Unlike basic hypervisors, VMware Workstation's virtual NAT switch (`VMnet8`) assigns private DHCP leases within the same subnet (`192.168.219.0/24`), providing outbound internet connectivity while enabling direct guest-to-guest communication out of the box.
4. **Base Snapshot:** Created snapshot `clean-install` via Snapshot Manager immediately after operating system provisioning.

### Issue Encountered & Resolution
- **Problem:** While outbound internet access (`ping 8.8.8.8`) and inbound ping from Windows to Linux (`192.168.219.131`) worked immediately, attempts to ping the Windows guest (`192.168.219.132`) from `lab01` initially failed with 100% packet loss.
- **Resolution:** Windows Defender Firewall blocks incoming ICMPv4 echo requests by default on private network profiles. Temporarily disabled the firewall profile inside the Windows guest to confirm layer-3 routing, achieving 0% packet loss across all four ICMP test probes.

## 4. Evidence
- [evidence/01-new-vm-wizard.png](evidence/01-new-vm-wizard.png) — Proof of VMware New Virtual Machine Wizard interface.
- [evidence/02-disk-settings.png](evidence/02-disk-settings.png) — Proof of 20 GB SCSI virtual disk configuration.
- [evidence/03-network-adapter.png](evidence/03-network-adapter.png) — Proof of network adapter set to NAT mode.
- [evidence/04-guest-uname.txt](evidence/04-guest-uname.txt) — Shell output demonstrating active Linux kernel (`7.0.0-38-generic`) on `lab01`.
- [evidence/05-ping-between-guests.txt](evidence/05-ping-between-guests.txt) — Full terminal logs verifying bidirectional ping between guests (`192.168.219.131` <-> `192.168.219.132`) and outbound internet access (`8.8.8.8`).
- [evidence/06-snapshot-list.png](evidence/06-snapshot-list.png) — Proof of baseline snapshot `clean-install` in Snapshot Manager.

## 5. What I would do differently
Instead of manual GUI configuration in VMware Workstation, I would automate the provisioning process using HashiCorp Vagrant (with the VMware provider) or Packer/Terraform code. Automating the pipeline eliminates human error in resource allocation, ensures strict version-controlled infrastructure as code (IaC), and reduces VM spin-up time from 40 minutes to a single non-interactive command.
