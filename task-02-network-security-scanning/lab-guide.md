# Task 2 Lab Guide (step by step, with screenshot checklist)

Before you start: both VMs running, `ping -c 2 192.168.56.103` works, `ip -br a` shows `eth0` (10.0.2.15) and `eth1` (192.168.56.101). Create the work folder:

```bash
mkdir -p ~/task2 && cd ~/task2
```

Take the screenshots marked **[S#]**. Save them as `S01.png`, `S02.png`, and so on, and send them to me in order, or in any order with their number.

---

## Part A. Reconnaissance

**Passive** (use your own domain or `example.com`)
```bash
whois example.com | head -30            # [S01]
nslookup example.com                     # [S02]
nslookup -type=MX example.com
dig example.com ANY +noall +answer
```
- Google dork in the browser: `site:example.com filetype:pdf`  **[S03]**
- Shodan: search your hostname or IP at shodan.io  **[S04]** (a free account is enough)

**Active (lab only)**
```bash
nmap -sn 192.168.56.0/24                 # ping sweep  [S05]
nc -nv 192.168.56.103 21                 # FTP banner  [S06]  (press Ctrl+C to exit)
printf 'HEAD / HTTP/1.0\r\n\r\n' | nc 192.168.56.103 80
```

## Part B. Port and service scanning
```bash
sudo nmap -sS 192.168.56.103                          # [S07]
sudo nmap -sU --top-ports 50 192.168.56.103           # [S08]  (takes a few minutes)
sudo nmap -sV 192.168.56.103                          # [S09]
sudo nmap -O 192.168.56.103                           # [S10]
sudo nmap -sS -sV -O -oA ~/task2/nmap-full 192.168.56.103
xsltproc ~/task2/nmap-full.xml -o ~/task2/nmap-full.html
ls -la ~/task2                                        # [S11]
firefox ~/task2/nmap-full.html                        # [S12] HTML report
```
Or run all in one go with the helper: `bash scripts/scan-target.sh 192.168.56.103`.

## Part C. Vulnerability scanning (OpenVAS)
```bash
sudo gvm-setup            # long; note the admin password
sudo gvm-check-setup      # [S13] final "OK" line
sudo gvm-start
```
Browser: `https://127.0.0.1:9392`
1. Dashboard after login **[S14]**
2. New Target `192.168.56.103` **[S15]**
3. New Task (Full and fast) running **[S16]**
4. Finished report summary with severity counts **[S17]**
5. A detailed Critical/High finding page **[S18]**
6. Export report as PDF **[S19]** (save as `reports/openvas-metasploitable2.pdf`)

## Part D. Wireshark analysis
Start a capture on `eth1` (use `eth0` for DNS).
```bash
# HTTP
firefox http://192.168.56.103/dvwa/        # filter: http          [S20]
# DNS (capture on eth0)
nslookup example.com                       # filter: dns           [S21]
# FTP (plain-text credentials)
ftp 192.168.56.103                         # msfadmin / msfadmin, then: ls, quit
```
- FTP filter `ftp`, then Follow > TCP Stream showing `USER` and `PASS`  **[S22]**
- SYN flood (short, lab only):
  ```bash
  sudo hping3 -S -p 80 -i u1000 -c 2000 192.168.56.103
  ```
  Filter `tcp.flags.syn == 1 && tcp.flags.ack == 0`  **[S23]**; Statistics > IO Graph  **[S24]**
- Save captures into `captures/`.

If `hping3` is missing: `sudo apt install -y hping3`.

## Part E. Firewall (iptables) on Metasploitable
```bash
# Kali, before:
sudo nmap -p 80 192.168.56.103                  # open     [S25]
# Metasploitable:
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
sudo iptables -L -n --line-numbers              # [S26]
# Kali, after:
sudo nmap -p 80 192.168.56.103                  # filtered [S27]
# Metasploitable, undo:
sudo iptables -D INPUT -p tcp --dport 80 -j DROP
```

## After all parts
- Copy outputs into the repo folders: `scans/`, `reports/`, `captures/`, `screenshots/`.
- Snapshot both VMs.
- Record the 5-minute video with `video-script.md`.

## Safety
- Scan and attack only `192.168.56.103`. Keep Metasploitable Host-Only.
- Keep the SYN flood short and limited with `-c`.
- Remove the iptables rules when done.
