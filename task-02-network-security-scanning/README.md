# Task 2: Network Security & Scanning

**Program:** ApexPlanet Cybersecurity & Ethical Hacking Internship
**Intern:** Talluri Anil Babu
**Timeline:** Days 13-24

Reconnaissance, port and service scanning, vulnerability scanning (OpenVAS), packet analysis with Wireshark, and firewall basics (iptables), all performed in my isolated lab.

> All active scanning and attack simulation is done only against my own Metasploitable2 VM on a Host-Only network. Passive reconnaissance is done only on my own domain or on `example.com`.

## Lab

| Machine | Role | Address |
|---|---|---|
| Kali Linux | Scanner / analyst | 192.168.56.101 (Host-Only), 10.0.2.15 (NAT) |
| Metasploitable2 | Target | 192.168.56.103 (Host-Only only) |

## Repository Structure

```
task-02-network-security-scanning/
├── README.md
├── notes/
│   ├── 01-reconnaissance.md
│   ├── 02-port-service-scanning.md
│   ├── 03-vulnerability-scanning-openvas.md
│   ├── 04-wireshark-traffic-analysis.md
│   └── 05-firewall-iptables.md
├── lab-guide.md
├── scripts/
│   └── scan-target.sh
├── scans/                    (Nmap output files: .nmap, .gnmap, .xml)
├── reports/                  (OpenVAS PDF report)
├── captures/                 (Wireshark .pcapng files)
├── screenshots/
├── video-script.md
└── Task2_Network_Scanning_Report.docx
```

## Deliverables Checklist

- [*] Nmap scan report (`scans/`)
- [*] OpenVAS vulnerability report (`reports/`)
- [*] Detailed scan analysis (report + notes)
- [*] 5-minute demo video (LinkedIn "Featured")

## Disclaimer

For education only. No real systems were scanned or attacked.
