#!/usr/bin/env bash
# Run the Task 2 Nmap scans against a lab target and save the reports.
# Usage: bash scan-target.sh 192.168.56.103
# Only use this on machines you own (the lab Metasploitable VM).
set -e
TARGET="${1:-192.168.56.103}"
OUT="$HOME/task2/scans"
mkdir -p "$OUT"
echo "Target: $TARGET   Output: $OUT"
echo

echo "=== 1. Host discovery (ping sweep of the /24) ==="
nmap -sn "${TARGET%.*}.0/24" -oN "$OUT/01-ping-sweep.nmap"

echo "=== 2. TCP SYN scan (top 1000 ports) ==="
sudo nmap -sS "$TARGET" -oN "$OUT/02-tcp-syn.nmap"

echo "=== 3. UDP scan (top 50 ports) ==="
sudo nmap -sU --top-ports 50 "$TARGET" -oN "$OUT/03-udp-top50.nmap"

echo "=== 4. Service version detection ==="
sudo nmap -sV "$TARGET" -oN "$OUT/04-service-version.nmap"

echo "=== 5. OS detection ==="
sudo nmap -O "$TARGET" -oN "$OUT/05-os-detection.nmap"

echo "=== 6. Combined report (all formats) ==="
sudo nmap -sS -sV -O -oA "$OUT/nmap-full" "$TARGET"
if command -v xsltproc >/dev/null 2>&1; then
  xsltproc "$OUT/nmap-full.xml" -o "$OUT/nmap-full.html"
  echo "HTML report: $OUT/nmap-full.html"
fi

echo
echo "Done. Files:"
ls -la "$OUT"
