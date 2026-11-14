iconv -f RK1048 -t UTF-8 staff-broken.csv | sed 's/\r$//' > staff-fixed.csv
