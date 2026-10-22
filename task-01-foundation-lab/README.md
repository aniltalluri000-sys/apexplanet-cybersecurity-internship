# Task 1: Foundation & Environment Setup

**Program:** ApexPlanet Cybersecurity & Ethical Hacking Internship
**Intern:** Talluri Anil Babu
**Timeline:** Days 1-12

This repository contains my Task 1 work: cybersecurity fundamentals, a private hacking lab (Kali Linux attacker + Metasploitable2 / DVWA targets on a Host-Only network), Linux and networking notes, cryptography hands-on with OpenSSL, and tool familiarization.

> All testing is done only inside my own isolated lab network. No real systems were targeted.

## Repository Structure

```
.
├── README.md
├── notes/
│   ├── 01-cybersecurity-basics.md
│   ├── 02-networking-basics.md
│   ├── 03-cryptography-basics.md
│   └── 04-tool-familiarization.md
├── linux-cheatsheet.md
├── Task1_Lab_Setup_Report.docx
├── video-script.md
├── lab-setup/
│   ├── lab-setup-guide.md
│   ├── test-capture.pcapng
│   └── screenshots/
└── crypto-demo/
    ├── openssl-demo.sh
    └── sample-output.txt
```

## Lab Overview

| Machine | Role | OS | Network |
|---|---|---|---|
| Kali Linux | Attacker | Kali Linux (kali-rolling) | NAT `10.0.2.15` + Host-Only `192.168.56.101` |
| Metasploitable2 | Target | Ubuntu 8.04 (intentionally vulnerable) | Host-Only only, `192.168.56.103` |
| DVWA | Web target | Runs on Metasploitable2 at `http://192.168.56.103/dvwa` | Host-Only only |

Host-Only network: `192.168.56.0/24` (VirtualBox default).

## Deliverables Checklist

- [x] Notes and Linux cheat-sheet (this repo)
- [x] Lab Setup Report with screenshots
- [x] 5-minute video walkthrough (LinkedIn "Featured")

## Disclaimer

This work is for education and is performed only on systems I own, inside an isolated lab.
