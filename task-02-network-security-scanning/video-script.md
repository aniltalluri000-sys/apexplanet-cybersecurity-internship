# Task 2 Demo Video: Script with Speech (about 5 minutes)

The brochure asks for a 5-minute demo video **showing a scan and its findings**. Record your screen and speak over it (or add the voice later in Clipchamp). Do the DO/TYPE parts on screen and read the SAY parts slowly.

**Before recording:** both VMs running; Kali terminal font enlarged; OpenVAS finished with the report ready in the browser; Wireshark open; `~/task2/nmap-full.html` available; iptables rule NOT yet added. Run `clear`. Start recording (Win + Alt + R).

---

## Part 1 (0:00 - 0:25) Introduction
**SHOW:** VirtualBox with both VMs.

**SAY:**
"Hello, I'm Talluri Anil Babu. This is ApexPlanet Cybersecurity Internship Task 2, Network Security and Scanning. In this demo I scan my lab target, Metasploitable 2, find its vulnerabilities, analyze the traffic, and then block a scan with a firewall rule."

## Part 2 (0:25 - 1:05) Reconnaissance
**TYPE:**
```bash
whois example.com | head -15
nslookup example.com
nmap -sn 192.168.56.0/24
```
**SAY:**
"First, reconnaissance. Whois and nslookup are passive: they only use public information, here for example dot com. Next, a ping sweep, which is active reconnaissance inside my lab. It finds two live hosts: my Kali machine and the target at 192.168.56.103."

## Part 3 (1:05 - 2:05) Port and service scanning
**TYPE:**
```bash
sudo nmap -sS -sV -O 192.168.56.103
```
**SAY:**
"Now the main scan. S-S is a TCP SYN scan, S-V detects service versions, and capital O detects the operating system. The target has many open ports. Port 21 runs vsftpd 2.3.4, which has a known backdoor. Port 22 is an old OpenSSH. Port 23 is Telnet, which sends passwords in plain text. Port 80 is Apache 2.2.8, and there are also Samba, MySQL, PostgreSQL and a root shell on port 1524. Nmap also guesses the OS as Linux. I saved this scan as a report with the dash o A option."

**DO:** open `~/task2/nmap-full.html` in Firefox for a few seconds.

## Part 4 (2:05 - 3:05) Vulnerability report (OpenVAS)
**SHOW:** OpenVAS in the browser: the finished report summary with severity counts, then one Critical finding.

**SAY:**
"For vulnerability scanning I used OpenVAS against the same target with the Full and Fast configuration. The report shows the findings by severity: critical, high, medium and low. This critical finding is the vsftpd backdoor, with a CVSS score of ten. Fixing it means removing or upgrading the service. I exported the full report as a PDF."

## Part 5 (3:05 - 4:05) Wireshark: FTP credentials and SYN flood
**DO:** start the capture on eth1.
**TYPE:**
```bash
ftp 192.168.56.103
```
Log in with `msfadmin` / `msfadmin`, then type `quit`.

**SAY:**
"Next, Wireshark. I log in to the FTP server and capture the traffic. Filtering for FTP and following the TCP stream, the username and password are visible in plain text. That's why FTP should be replaced by SFTP."

**TYPE:**
```bash
sudo hping3 -S -p 80 -i u1000 -c 2000 192.168.56.103
```
**SAY:**
"Now a short SYN flood simulation with hping3, limited to two thousand packets on my own lab target. In Wireshark, the filter for SYN without ACK shows many new connection attempts from one source, and the IO graph shows the spike."

## Part 6 (4:05 - 4:50) Firewall: blocking a scan
**TYPE on Kali:**
```bash
sudo nmap -p 80 192.168.56.103
```
**TYPE on Metasploitable:**
```bash
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
sudo iptables -L -n
```
**TYPE on Kali again:**
```bash
sudo nmap -p 80 192.168.56.103
```
**SAY:**
"Finally, firewall basics. Port 80 is open. On the target I add an iptables rule that drops traffic to port 80. Scanning again, the port now shows as filtered, so the firewall blocks it. Then I remove the rule."

**TYPE on Metasploitable:**
```bash
sudo iptables -D INPUT -p tcp --dport 80 -j DROP
```

## Part 7 (4:50 - 5:00) Closing
**SHOW:** the GitHub repository.

**SAY:**
"My Nmap reports, the OpenVAS report and my analysis are on GitHub. Thank you for watching."

Stop recording (Win + Alt + R).

---

## Tips
- Keep the SYN flood short, and only against `192.168.56.103`.
- Remove iptables rules afterwards (`sudo iptables -F`).
- If a command is slow (UDP scan, OpenVAS), show the finished result instead of waiting.
- LinkedIn title: "ApexPlanet Cybersecurity Internship - Task 2: Network Security & Scanning". Hashtags: #ApexPlanet #Cybersecurity #Nmap #OpenVAS #Wireshark #EthicalHacking
