# 02. Port & Service Scanning (Nmap)

Target: `192.168.56.103` (Metasploitable2). Create the output folder first: `mkdir -p ~/task2`.

## Port states

| State | Meaning |
|---|---|
| open | A service is accepting connections |
| closed | Reachable, but no service listening |
| filtered | A firewall drops the probes, so Nmap cannot tell |
| open\|filtered | Nmap cannot decide (common in UDP scans) |

## Scan types

| Scan | Command | How it works |
|---|---|---|
| TCP SYN ("stealth") | `sudo nmap -sS 192.168.56.103` | Sends SYN, reads SYN/ACK or RST, never completes the handshake |
| TCP connect | `nmap -sT 192.168.56.103` | Full handshake (no root needed, noisier) |
| UDP | `sudo nmap -sU --top-ports 50 192.168.56.103` | Slow; UDP has no handshake, so many ports show `open\|filtered` |
| Service version | `sudo nmap -sV 192.168.56.103` | Probes open ports to identify software and version |
| OS detection | `sudo nmap -O 192.168.56.103` | Guesses the OS from TCP/IP stack behaviour |
| All ports | `sudo nmap -p- 192.168.56.103` | Scans all 65535 TCP ports |
| Aggressive | `sudo nmap -A 192.168.56.103` | OS + version + default scripts + traceroute |
| Default scripts | `sudo nmap -sC 192.168.56.103` | Runs safe NSE scripts |

## Combined scan with saved report

```bash
sudo nmap -sS -sV -O -oA ~/task2/nmap-full 192.168.56.103
```

`-oA` writes three files: `nmap-full.nmap` (normal text), `nmap-full.gnmap` (grepable) and `nmap-full.xml`.

Convert the XML to an HTML report:
```bash
xsltproc ~/task2/nmap-full.xml -o ~/task2/nmap-full.html
```

## How to write the scan analysis

For each important open port, record: port/protocol, service, version, why it is risky.

| Port | Service | Version (from lab scan) | Risk |
|---|---|---|---|
| 21 | FTP | vsftpd 2.3.4 | Known backdoor in this exact version; plain-text login |
| 22 | SSH | OpenSSH 4.7p1 | Old version, weak ciphers |
| 23 | Telnet | Linux telnetd | Plain-text remote login |
| 80 | HTTP | Apache 2.2.8 | Outdated web server, vulnerable web apps (DVWA) |
| 445 | SMB | Samba 3.X | Old Samba, several known flaws |
| 1524 | bindshell | Metasploitable root shell | Direct root shell, no authentication |
| 3306 | MySQL | MySQL 5.0.51a | Old database, may allow remote access |
| 6667 | IRC | UnrealIRCd | Known backdoored version |

Add your own findings from the Task 2 scans (OS guess, UDP ports found, extra services).

## Useful options

- `-Pn` skip host discovery (treat host as up)
- `-T4` faster timing (fine in a lab)
- `-v` verbose, `--reason` show why a port has its state
- `--open` show only open ports
