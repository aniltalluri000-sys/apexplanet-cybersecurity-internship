# 01. Cybersecurity Basics

## CIA Triad

| Principle | Meaning | Example control | Example attack on it |
|---|---|---|---|
| **Confidentiality** | Only authorised people can read data | Encryption, access control, MFA | Data breach, sniffing |
| **Integrity** | Data is accurate and not tampered with | Hashing, digital signatures, checksums | Man-in-the-middle modification, SQL injection |
| **Availability** | Systems and data are usable when needed | Backups, redundancy, DDoS protection | DDoS, ransomware |

## Threat Types

| Threat | What it is | Typical defence |
|---|---|---|
| **Phishing** | Fake emails/pages that trick users into giving credentials or running malware | Awareness training, email filtering, MFA |
| **Malware** | Malicious software: viruses, worms, trojans, spyware | Antivirus/EDR, patching, least privilege |
| **DDoS** | Flooding a service with traffic to make it unavailable | Rate limiting, CDN/scrubbing, firewalls |
| **SQL Injection** | Untrusted input changes a database query | Prepared statements, input validation |
| **Brute Force** | Trying many passwords until one works | Strong passwords, lockout, MFA, fail2ban |
| **Ransomware** | Encrypts files and demands payment | Offline backups, patching, segmentation |

## Attack Vectors

- **Social engineering:** manipulating people (phishing, vishing, pretexting, baiting). The human is the weakest link.
- **Wireless attacks:** rogue access points, evil twin, WPA handshake capture, weak Wi-Fi passwords. Defence: WPA3/WPA2-Enterprise, disable WPS.
- **Insider threats:** employees or contractors who misuse access, intentionally or by mistake. Defence: least privilege, logging, separation of duties.

## Ethical Hacking Phases (overview)

1. Reconnaissance
2. Scanning and enumeration
3. Gaining access (exploitation)
4. Maintaining access / post-exploitation
5. Covering tracks and reporting

Ethical hacking always requires **written permission and a defined scope**.
