# 04. Packet Analysis with Wireshark

Capture on the lab interface (`eth1`). Generate each kind of traffic while capturing, then stop and filter.

## HTTP

- Generate: open `http://192.168.56.103/dvwa/` in Firefox.
- Filter: `http`
- Observe: `GET` requests, response codes, headers (server version, cookies). Right-click > Follow > HTTP Stream.

## DNS

- Generate: `nslookup example.com`
- Filter: `dns`
- Observe: query and response, record type, the DNS server used. (Note: DNS needs the NAT adapter, `eth0`, so capture on `eth0` for this one.)

## FTP (plain-text credentials)

- Generate:
  ```bash
  ftp 192.168.56.103
  # Name: msfadmin
  # Password: msfadmin
  ftp> ls
  ftp> quit
  ```
- Filter: `ftp`
- Right-click a packet > Follow > TCP Stream. The `USER` and `PASS` commands are visible in plain text.
- Useful filter to find the password: `ftp.request.command == "PASS"`
- Lesson: FTP, Telnet and HTTP login forms send credentials unencrypted. Use SFTP/SSH/HTTPS.

## SYN flood simulation (lab only)

> Only against your own Metasploitable VM, only for a few seconds, only on the Host-Only network.

```bash
sudo hping3 -S -p 80 -i u1000 -c 2000 192.168.56.103
```

- `-S` set SYN flag, `-p 80` target port, `-i u1000` one packet every 1000 microseconds, `-c 2000` stop after 2000 packets.
- A real flood uses `--flood` (as fast as possible), which is not needed for the demo.
- Filter: `tcp.flags.syn == 1 && tcp.flags.ack == 0`
- Statistics > Conversations (TCP) or Statistics > IO Graph shows the spike in SYN packets from one source.
- Observe: many SYNs with few completed handshakes; the target answers SYN/ACK and waits (half-open connections).
- Defence: SYN cookies, rate limiting, firewall rules, upstream DDoS protection.

## Useful filters

| Filter | Shows |
|---|---|
| `ip.addr == 192.168.56.103` | Traffic to/from the target |
| `tcp.port == 21` | FTP control traffic |
| `tcp.flags.syn == 1 && tcp.flags.ack == 0` | New connection attempts (SYN only) |
| `tcp.flags.reset == 1` | Resets (closed ports during a scan) |
| `icmp` | Ping |
| `!arp` | Hide ARP noise |

## Save evidence

File > Save As: `captures/http-ftp-dns.pcapng`, `captures/syn-flood.pcapng`.
