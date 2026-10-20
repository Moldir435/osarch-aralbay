# Lab 1 — Your first virtual machine

Pair:None                     Driver first half:Moldir
Machine:Huawei
Date:18.10.2026

## What I did

Checked the linux distribution

```
lsb_release -a > guest-release.txt
Distributor ID: Ubuntu
Description: Ubuntu 26.04.1 LTS
Release: 26.04
Codename: resolute
```
Checked the guest operating system release and saved the output in guest-release.txt.
created a snapshot of the virtual machine.
Intentionally broke the virtual machine and restored it using the snapshot.

```

## Result
Created a virtual machine, checked the Linux distribution, saved a snapshot, and restored the virtual machine to its previous working state.

## What did not work the first time

The virtual machine was intentionally broken to test recovery. I restored it using the snapshot and checked that it worked again.

## Evidence

- `evidence/guest-release.txt` — shows the Linux system information.
- `evidence/vm-settings.png` — shows the virtual machine settings.
- `evidence/broken.png` — shows the broken virtual machine.
- `evidence/snapshot-list.png` — shows the snapshot list.
