# Lab 5 — Encoding forensics

Pair:None Driver first half:Moldir
Machine: Windows 11 host, Ubuntu 26.04 LTS guest (lab01)
Date: 14.11.2026

## What I did

Diagnosis first, the file was not modified:

```bash
file staff-broken.csv
head -c 16 staff-broken.csv | xxd
iconv -f CP1251 -t UTF-8 staff-broken.csv | head -n 5
iconv -f RK1048 -t UTF-8 staff-broken.csv | head -n 5
```

Then the fix (`scripts/fix.sh`):

```bash
printf '\xEF\xBB\xBF' > staff-fixed.csv && iconv -f RK1048 -t UTF-8 staff-broken.csv | sed 's/\r$//' >> staff-fixed.csv
```

## Result

| | Before | After |
|---|---|---|
| Encoding | RK1048 (Kazakh code page, close to Windows-1251) | UTF-8 |
| Line ending | CRLF | LF |
| BOM | none (file starts with `d2 e0`) | present (`EF BB BF`) |

`file` after the fix: `Unicode text, UTF-8 (with BOM) text`, with no mention of CRLF.

How I identified the encoding: the first bytes `d2 e0 e1 2e b9 3b` read as "Таб.№;" in Windows-1251. But with CP1251 the Kazakh letters came out wrong (Ј, Є, Ў instead of Ә, Қ, Ұ). With RK1048 they came out correct.

BOM: kept. UTF-8 does not need it, but without it Excel reads the file as cp1251 and shows "РўР°Р±...". Excel is one of the three applications the lab asks to verify.

Verification: the fixed file was opened in Excel, in LibreOffice Calc and with `cat` over SSH. The names (Қасымова, Нұрланов) read correctly in all three, see `opens-correctly.png`.

## What did not work the first time

- My first guess was CP1251. Russian text was fine, but the Kazakh letters were wrong (Ј, Є, Ў). I found RK1048 and regenerated the file.
- In one command I left out the `>`, so `staff-fixed.csv` was not overwritten and the output only went to the screen.
- Without a BOM, Excel showed "РўР°Р±..." instead of the text. I added the BOM.
- Once Excel re-saved the file and the Kazakh letters were replaced by "?". I copied the file again from the VM and now always answer "No" to "Save changes?".

## Evidence

- [evidence/file-before.txt](evidence/file-before.txt) — `file` before the fix: non-standard encoding, CRLF
- [evidence/hexdump-before.txt](evidence/hexdump-before.txt) — first 16 bytes, shows there is no BOM
- [evidence/file-after.txt](evidence/file-after.txt) — `file` after the fix: UTF-8 with BOM, no CRLF
- [evidence/staff-broken.csv](evidence/staff-broken.csv) — the original file
- [evidence/staff-fixed.csv](evidence/staff-fixed.csv) — the fixed file
- [evidence/opens-correctly.png](evidence/opens-correctly.png) — Excel, LibreOffice and `cat`
- [scripts/fix.sh](scripts/fix.sh) — the fix command
