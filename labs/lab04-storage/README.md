# Lab 4 — Partition, mirror, fail, recover

Pair:None                    Driver first half:Moldir
Machine:Huawei
Date:08.11.2026

## What I did

Three extra 2 GB virtual disks were attached to the guest. Layout before:

lsblk | tee lsblk-before.txt

Partitioned the three disks with GPT, one RAID partition each:

```
sudo parted /dev/sdb --script mklabel gpt mkpart primary 0% 100% set 1 raid on
sudo parted /dev/sdc --script mklabel gpt mkpart primary 0% 100% set 1 raid on
sudo parted /dev/sdd --script mklabel gpt mkpart primary 0% 100% set 1 raid on

```


Built the mirror from two disks and mounted it:

```
sudo apt install -y mdadm
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
sudo mkfs.ext4 /dev/md0
sudo mkdir -p /mnt/mirror
sudo mount /dev/md0 /mnt/mirror
(cat /proc/mdstat; sudo mdadm --detail /dev/md0) | tee array-healthy.txt

```

Wrote a file and recorded its checksum:

```
echo "OSArch lab4 test" | sudo tee /mnt/mirror/test.txt
sha256sum /mnt/mirror/test.txt | tee checksum-before.txt

```

Failed and removed one half of the mirror, then checked the data:


```
sudo mdadm /dev/md0 --fail /dev/sdc1
sudo mdadm /dev/md0 --remove /dev/sdc1
(cat /proc/mdstat; sudo mdadm --detail /dev/md0) | tee array-degraded.txt
cat /mnt/mirror/test.txt
sha256sum /mnt/mirror/test.txt | tee checksum-after-failure.txt

```

Added the third disk and rebuilt:

```
sudo mdadm /dev/md0 --add /dev/sdd1
cat /proc/mdstat
(cat /proc/mdstat; sudo mdadm --detail /dev/md0) | tee array-rebuilt.txt

```

Windows (lab02)

PowerShell as administrator, new 2 GB disk (disk number 1):

Get-Disk
Initialize-Disk -Number 1 -PartitionStyle GPT
New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Lab04"
Get-Disk -Number 1

Output of the format step:

```
DriveLetter FriendlyName FileSystemType DriveType HealthStatus OperationalStatus SizeRemaining  Size
----------- ------------ -------------- --------- ------------ ----------------- -------------  ----
E           Lab04        NTFS           Fixed     Healthy      OK                      1.97 GB 1.98 GB

```

Array layout in the three states:

| State | /proc/mdstat | Members | mdadm State |
|---|---|---|---|
| Healthy | `[2/2] [UU]` | sdb1, sdc1 | clean |
| Degraded (sdc1 failed and removed) | `[2/1] [U_]` | sdb1 | clean, degraded |
| Rebuilt (sdd1 added) | `[2/2] [UU]` | sdb1, sdd1 | clean |


## Result

The SHA-256 checksum of test.txt is identical before and after the failure (checksum-before.txt and checksum-after-failure.txt), so the data survived the loss of one disk.

Windows: the new disk went from RAW to GPT, with one NTFS partition mounted as E: (label Lab04, about 2 GB). I chose GPT because MBR is limited to 2 TB disks and four primary partitions, while GPT has no such limits, is required for UEFI boot, and keeps a backup copy of its partition table.


## What did not work the first time

I added only one extra disk in VMware instead of three. lsblk inside the guest still showed only sda, which told me the disks were missing. I powered the VM off, checked the device list in the VM settings, added the other two disks and ran lsblk again.
Copy and paste did not work in the VMware console, so I typed every command by hand.
The rebuild finished within seconds because the disks are only 2 GB, so I never saw a progress percentage. /proc/mdstat right after --add already showed [UU].

## Evidence

- [evidence/lsblk-before.txt](evidence/lsblk-before.txt) — disk layout before building the array
- [evidence/array-healthy.txt](evidence/array-healthy.txt) — mirror with two active devices
- [evidence/array-degraded.txt](evidence/array-degraded.txt) — mirror running on one disk after the failure
- [evidence/checksum-before.txt](evidence/checksum-before.txt) — checksum of the test file on the healthy mirror
- [evidence/checksum-after-failure.txt](evidence/checksum-after-failure.txt) — same checksum with one disk gone, data intact
- [evidence/array-rebuilt.txt](evidence/array-rebuilt.txt) — mirror back to two active devices after adding the third disk