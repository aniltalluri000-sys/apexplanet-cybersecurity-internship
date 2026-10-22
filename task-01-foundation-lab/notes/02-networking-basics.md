# 02. Networking Basics

## OSI Model

| # | Layer | Function | Examples / PDU |
|---|---|---|---|
| 7 | Application | User-facing network services | HTTP, DNS, FTP, SMTP |
| 6 | Presentation | Encoding, encryption, compression | TLS/SSL, JPEG |
| 5 | Session | Opens, manages, closes sessions | NetBIOS, RPC |
| 4 | Transport | End-to-end delivery, ports | TCP, UDP (segments) |
| 3 | Network | Logical addressing, routing | IP, ICMP, routers (packets) |
| 2 | Data Link | Local delivery, MAC addressing | Ethernet, ARP, switches (frames) |
| 1 | Physical | Bits on the wire / air | Cables, Wi-Fi radio |

Memory aid (top to bottom): *All People Seem To Need Data Processing*.

## TCP/IP Suite (4 layers)

| TCP/IP layer | Maps to OSI | Protocols |
|---|---|---|
| Application | 5-7 | HTTP, HTTPS, DNS, FTP, SSH, SMTP |
| Transport | 4 | TCP, UDP |
| Internet | 3 | IP, ICMP, ARP |
| Network Access | 1-2 | Ethernet, Wi-Fi |

**TCP three-way handshake:** SYN -> SYN/ACK -> ACK (reliable, connection-oriented). **UDP** is connectionless and faster, with no delivery guarantee.

## DNS

Translates names to IPs. Flow: browser cache -> OS cache -> recursive resolver -> root -> TLD (.com) -> authoritative server.

Common records: `A` (IPv4), `AAAA` (IPv6), `CNAME` (alias), `MX` (mail), `NS` (name server), `TXT` (text, SPF/DKIM).

## HTTP / HTTPS

- HTTP methods: GET, POST, PUT, DELETE, HEAD, OPTIONS
- Status codes: 200 OK, 301/302 redirect, 401 unauthorised, 403 forbidden, 404 not found, 500 server error
- HTTP sends data in plain text, so it can be sniffed. **HTTPS = HTTP over TLS**: encrypts traffic and authenticates the server with a certificate.
- Default ports: HTTP 80, HTTPS 443.

## IP Addressing, Subnetting, NAT

- **IPv4:** 32-bit, written as four octets, e.g. `192.168.56.101`
- **Private ranges:** `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`
- **CIDR / subnet example:** `192.168.56.0/24` -> mask `255.255.255.0`, 256 addresses, 254 usable hosts (`.1` to `.254`), network `.0`, broadcast `.255`
- Hosts in a subnet = 2^(32 - prefix) - 2
- **NAT:** a router translates many private IPs to one public IP (PAT uses ports to track connections). Saves public addresses and hides internal hosts.

## Common Ports

| Port | Service | Port | Service |
|---|---|---|---|
| 21 | FTP | 80 | HTTP |
| 22 | SSH | 110 | POP3 |
| 23 | Telnet | 143 | IMAP |
| 25 | SMTP | 443 | HTTPS |
| 53 | DNS | 3306 | MySQL |
| 445 | SMB | 3389 | RDP |
