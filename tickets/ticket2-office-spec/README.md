# Ticket 2 — Office hardware specification

## 1. What was asked

> From: Daniyar K. (Director)
> Subject: computers for the new office
>
> We are opening the second office and need four computers — accountant,
> sales, web developer, designer. Budget 3,000,000 tenge for everything.
> Everyone says we should just buy the same four machines, is that right?
> Make sure they last a few years. Monitors included.

## 2. What was actually needed

**Where the request is wrong.** Four identical machines are not the right
answer. The four roles carry different loads (accounting software and
spreadsheets; CRM with many browser tabs and video calls; compilers,
containers and VMs; image and video editing), so they hit different
bottlenecks. Identical machines would be overbuilt for the accountant and
underbuilt for the designer. The budget averages 750,000 KZT per person, but
it should be split by need, not evenly.

**What the request left out.**
- Which software each person runs, and whether it is licensed.
- Which operating system, and who pays for the licence.
- Monitor size and count (a designer needs a better one than an accountant).
- Peripherals, desktop or laptop, and what "a few years" means.
- Whether the budget includes VAT, delivery and warranty.

**What I would have asked Daniyar, and what I assumed instead.**

| Question | Assumption |
|---|---|
| How long must they last? | 4 years |
| Desktop or laptop? | Desktop (cheaper per performance, easier to upgrade) |
| Which OS? | Windows 11 Pro, OEI licence (tied to one PC, cheaper than the boxed key) |
| Are keyboards and mice in the budget? | No: the office already has them (to confirm with Daniyar) |
| Does 3,000,000 include VAT and delivery? | Yes, all prices are the shelf prices on Sulpak.kz and Technodom.kz |
| Who assembles the machines? | Compared in question 2 below |
| Which platform? | AM4 (AMD): cheap and compatible with parts already checked. Trade-off: old platform, limited upgrade path |

## 3. What I did

1. Chose Sulpak.kz as the main vendor so that prices are comparable (the
   designer's monitor comes from Technodom.kz, because I did not find a
   suitable one on Sulpak), and recorded the date next to every price.
2. Picked a common base for all four machines (AM4 platform, ASRock B550M
   board, DDR4) so that compatibility was checked once.
3. Corrected parts that did not fit together as I went:
   - First CPU was a Ryzen 7 7800X3D (socket AM5), but the board is AM4 and
     the memory DDR4. Replaced with Ryzen 5 5600GT (AM4).
   - First SSDs were external drives and a 500 GB model; the ticket requires
     an internal 1 TB SSD. Replaced with Samsung 990 1 TB M.2.
   - The OS was a Windows Home bundle with Office and antivirus (199,990 KZT);
     the ticket needs a licensed Windows 11 Pro. Replaced with Windows 11 Pro
     OEI (110,041 KZT).
4. Built the accountant machine first, then derived the other three from it,
   changing only what the load requires:
   - sales: 32 GB of memory (2 × 16 GB);
   - web developer: Ryzen 7 5700G (8 cores, OEM, so a separate cooler) and 32 GB;
   - designer: 32 GB and an IPS monitor.
5. Wrote the reasoning for each machine in builds.md (load, bottleneck,
   trade-off) and checked the sum against the 3,000,000 KZT budget:
   2,691,830 KZT in total.
6. Priced pre-built machines for question 2 and answered the three questions.

## Answers to the three questions

**1. Which machine do I upgrade first, in eighteen months?**
The designer's machine, by adding a discrete graphics card. It has only
integrated graphics, which is the first thing to feel slow on large image
files and video export. The 750 W power supply and the PCIe slot are already
in the build, so the upgrade needs no other part to be replaced.

**2. The same four as pre-built machines.**

| Role | Pre-built model (Sulpak) | Price KZT | Date |
|---|---|---|---|
| Accountant | ARG Game Y05 3060-I5-16-1024-WIN11 (i5-12400F, RTX 3060, 16 GB, 1 TB SSD, Windows 11), no monitor | 552,980 (519,990 + monitor 32,990) | 2026-11-17 |
| Sales | ARG Game Y05 5060 (i5-12400F, RTX 5060, 32 GB, 1 TB SSD), no OS, no monitor. Closest found, same unit as the designer | 813,021 (669,990 + monitor 32,990 + Windows 110,041) | 2026-11-17 |
| Web developer | Same unit as sales: 6 cores, not the 8 of my build. Closest found | 813,021 (669,990 + monitor 32,990 + Windows 110,041) | 2026-11-17 |
| Designer | ARG Game Y05 5060 (i5-12400F, RTX 5060, 32 GB, 1 TB SSD), no OS, no monitor | 819,021 (669,990 + monitor 38,990 + Windows 110,041) | 2026-11-17 |
| **Total** | | **2,998,043** | |

My own builds cost 2,691,830 KZT, so the pre-built set is 306,213 KZT more
expensive. The accountant's unit is a discounted display model (list price
688,990 KZT), so the real gap is larger. For sales and web developer I did
not find a pre-built matching the load, so the same unit was priced for
both, and all four pre-builts include a graphics card that three of the four
roles do not need.

What the company gains by buying pre-built: a single warranty and a single
point of contact when something breaks, no time spent choosing and checking
compatibility, and finished machines delivered ready to use.
What it loses: the ability to put money where the load is (the pre-builts I
found are fixed gaming configurations, so money goes into a graphics card
instead of memory or cores), easy upgrades (proprietary parts are common in
ready-made cases), and money, as shown by the totals above.

**3. Who will complain about performance within a month, and about what?**
The designer, about slowness with large files (filters, layers, export),
because the machine has integrated graphics only. The sales manager is
protected by 32 GB of memory and the developer by 8 cores, and the
accountant's load is light.

## 4. Evidence

- `budget.csv` — every component with model, price in KZT, source link and
  the date the price was taken; this is what the totals in builds.md are
  calculated from.
- `builds.md` — the reasoning for each of the four machines and the budget check.
- `evidence/vendor-quotes/` — screenshots of the product pages with the
  price visible; they prove the prices on that date. Includes the two
  pre-built pages used in question 2 (`prebuilt-accountant.png`,
  `prebuilt-designer.png`).
- `evidence/pcpartpicker-links.md` — a note on why PCPartPicker was not used
  (it does not list Kazakhstan vendors); compatibility was checked from the
  product page specifications.

## 5. What I would do differently

I would compare the price of at least two candidates for each part before
writing it into the table. I replaced the CPU, SSD and operating system
several times because I took the first item I found without checking the
socket, the size and the licence type. I also found later that a 16 GB
Apacer module (100,566 KZT) is cheaper than the Kingston module I had picked
for the accountant (112,578 KZT) with the same specification, so I would
switch it and save about 12,000 KZT.
