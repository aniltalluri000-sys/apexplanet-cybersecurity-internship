# 04. Tool Familiarization

> Run these only against your own lab machines (Host-Only network).

## Wireshark (packet capture and analysis)

- Start capture on the Host-Only interface (e.g. `eth1` in Kali).
- Useful display filters:
  - `ip.addr == 192.168.56.103`
  - `tcp.port == 80`
  - `http`, `dns`, `icmp`
  - `tcp.flags.syn == 1 && tcp.flags.ack == 0`
- Test capture: generate traffic with `ping 192.168.56.103` and open Metasploitable's web page, then show the ICMP and HTTP packets.
- Right-click a packet -> Follow -> TCP Stream to see a full conversation.

## Nmap (network scanning)

```bash
nmap 192.168.56.103                 # default scan, top 1000 ports
nmap -sn 192.168.56.0/24            # host discovery (ping sweep)
nmap -sV 192.168.56.103             # service version detection
nmap -O 192.168.56.103              # OS detection (needs root)
nmap -p- 192.168.56.103             # all 65535 ports
nmap -A 192.168.56.103              # aggressive: OS, version, scripts, traceroute
nmap -oN scan.txt 192.168.56.103    # save output
```

## Burp Suite (web proxy)

1. Open Burp Community -> Proxy -> Intercept.
2. Set the browser proxy to `127.0.0.1:8080` (or use Burp's built-in browser).
3. Browse to DVWA, turn Intercept on, and observe the request in Burp.
4. Send a request to **Repeater** to edit and resend it.
5. For HTTPS sites, install Burp's CA certificate in the browser.

## Netcat (network debugging)

```bash
nc -zv 192.168.56.103 21-25         # port check
nc -lvnp 4444                        # listen on a port
nc 192.168.56.103 80                 # connect to a port
printf 'HEAD / HTTP/1.0\r\n\r\n' | nc 192.168.56.103 80   # manual HTTP request (banner)
nc -lvnp 5000 > received.txt         # receive a file
nc 127.0.0.1 5000 < sample.txt       # send a file
```

## Tool Summary

| Tool | Purpose | Layer / area |
|---|---|---|
| Wireshark | See exactly what is on the wire | Network traffic analysis |
| Nmap | Find hosts, open ports, services | Recon and scanning |
| Burp Suite | Intercept and modify web requests | Web app testing |
| Netcat | Read/write raw TCP/UDP connections | Debugging, file transfer |
