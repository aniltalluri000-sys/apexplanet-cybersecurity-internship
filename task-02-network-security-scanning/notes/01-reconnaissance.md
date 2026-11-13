# 01. Reconnaissance

Reconnaissance is the first phase of ethical hacking: collecting information about a target before testing it.

| Type | Meaning | Touches the target? |
|---|---|---|
| Passive | Using public sources only | No |
| Active | Sending packets to the target | Yes (needs permission) |

## Passive Reconnaissance

Use **your own domain** or `example.com` for practice.

| Tool | Command / use | What it reveals |
|---|---|---|
| Whois | `whois example.com` | Registrar, creation/expiry dates, name servers, contact (often privacy-protected) |
| Nslookup | `nslookup example.com` | IP address (A record) |
| Nslookup records | `nslookup -type=MX example.com`, `-type=NS`, `-type=TXT` | Mail servers, name servers, SPF/DKIM text |
| Dig | `dig example.com ANY +noall +answer` | All records in one go |
| Google Dorking | `site:example.com filetype:pdf`, `intitle:"index of"`, `inurl:login` | Exposed files, directory listings, login pages |
| Shodan | Search the hostname or IP on shodan.io | Open ports, banners, technologies seen from the internet |

### Useful Google dorks (use only on your own or permitted domains)

- `site:yourdomain.com` lists indexed pages
- `site:yourdomain.com filetype:pdf` finds PDFs
- `site:yourdomain.com inurl:admin` finds admin-like URLs
- `intitle:"index of" site:yourdomain.com` finds open directory listings

## Active Reconnaissance (lab only)

| Technique | Command | Purpose |
|---|---|---|
| Ping sweep | `nmap -sn 192.168.56.0/24` | Find live hosts on the lab network |
| Banner grabbing (netcat) | `nc -nv 192.168.56.103 21` | Read the FTP service banner |
| Banner grabbing (HTTP) | `printf 'HEAD / HTTP/1.0\r\n\r\n' \| nc 192.168.56.103 80` | Web server type and version |
| Banner grabbing (Nmap) | `nmap -sV --script=banner 192.168.56.103` | Banners for all open services |

## Why it matters

Banners and version numbers (for example `vsftpd 2.3.4`, `Apache 2.2.8`) let an attacker look up known vulnerabilities. Defenders reduce this by hiding version information and closing unused services.
