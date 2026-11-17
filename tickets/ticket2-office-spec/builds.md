# Ticket 2 — four builds

All prices: Sulpak.kz (designer monitor: Technodom.kz), in tenge, taken on 2026-11-16 (see budget.csv).
Common platform for all four machines: AMD AM4, ASRock B550M Phantom Gaming 4,
DDR4, Samsung 990 1 TB M.2 NVMe, Deepcool PF750 PSU, XG Dark Shadow case,
ARG M22R3F100 monitor (unless stated otherwise), Windows 11 Pro OEI.

The director's assumption ("the same four machines") is wrong: the four roles
hit four different bottlenecks, so the same money has to be split unevenly.

### Build 1 — accountant

**Load:** accounting software, Excel with large spreadsheets, a browser with
a few tabs, PDF documents. Light, mostly single-threaded work.

**Bottleneck:** nothing serious. The machine is bound by storage speed and
the monitor, not by CPU or memory. 16 GB is enough.

**Trade-off:** Ryzen 5 5600GT (6 cores, integrated graphics, cooler in the
box) instead of anything stronger: no graphics card and no separate cooler.
The cost is an old platform (AM4), so the upgrade path is limited.

**Total:** 599,831 KZT (budget.csv, rows 2–9)

### Build 2 — sales manager

**Load:** CRM in a browser, 30–40 tabs, Excel, several hours of video calls
a day, often all at the same time.

**Bottleneck:** memory, not CPU. A browser with forty tabs plus a video
call needs more than 16 GB to stay out of swap.

**Trade-off:** same CPU and platform as the accountant; the saved money went
into 32 GB (2 × Apacer 16 GB DDR4) instead of 16 GB. The CPU idles in this
role, the memory does not.

**Total:** 688,385 KZT (budget.csv, rows 10–18)

### Build 3 — web developer

**Load:** IDE, several browsers, Docker containers, sometimes virtual
machines, a local database.

**Bottleneck:** CPU cores and memory together. Containers and VMs each take
a share of both.

**Trade-off:** Ryzen 7 5700G (8 cores) instead of the 6-core 5600GT, and
32 GB of memory. The 5700G comes as an OEM part without a cooler, so a
cooler is bought separately. We did not go to 64 GB: 32 GB is enough for a
normal Docker setup, and the extra money went to the CPU.

**Total:** 709,229 KZT (budget.csv, rows 19–28)

### Build 4 — designer

**Load:** Photoshop / Illustrator / Figma, large image files, sometimes
video export; colour accuracy matters.

**Bottleneck:** the display and graphics. Wrong colours on the screen cannot
be fixed later by software, and integrated graphics will be the first thing
to feel slow on large files.

**Trade-off:** the monitor is an IPS panel (X-game 1T238IPS, 23.8", 100 Hz,
from Technodom, because I did not find a suitable IPS monitor on Sulpak). It
gives better colours and viewing angles than the standard office monitor,
but it is not factory-calibrated. 32 GB of memory like the sales build. The
planned first upgrade is a discrete graphics card (see question 1 in
README.md); a calibrated monitor would come after that.

**Total:** 694,385 KZT (budget.csv, rows 29–37)

### Budget check

| Machine | KZT |
|---|---|
| Accountant | 599,831 |
| Sales | 688,385 |
| Web developer | 709,229 |
| Designer | 694,385 |
| **Total** | **2,691,830** |
| Budget | 3,000,000 |
