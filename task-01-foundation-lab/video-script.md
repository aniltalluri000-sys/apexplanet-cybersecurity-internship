# 5-Minute Video Walkthrough Script (Task 1)

**Goal:** show your lab setup working, about 5 minutes. Record your screen with OBS Studio (free) or Windows Game Bar (Win+G), and speak over it. Upload to LinkedIn and add it under *Featured*.

**Before recording:** boot Kali and Metasploitable2, open a terminal, Wireshark and DVWA in a browser, and close anything personal on screen.

| Time | On screen | What to say |
|---|---|---|
| 0:00-0:30 | Title slide or terminal | "Hi, I'm Talluri Anil Babu. This is my ApexPlanet Cybersecurity internship Task 1: Foundation and Environment Setup. In this video I'll walk through my hacking lab." |
| 0:30-1:15 | VirtualBox Manager showing the VMs | "I'm using VirtualBox with two machines: Kali Linux as the attacker and Metasploitable2 as the vulnerable target. Both are connected to a private Host-Only network so nothing touches the internet." |
| 1:15-1:50 | Network Manager / VM settings (adapters) | "Here is the Host-Only network, 192.168.56.0/24. Kali has a NAT adapter for updates plus Host-Only. Metasploitable has Host-Only only, because it is intentionally vulnerable." |
| 1:50-2:30 | Kali terminal: `ip a`, `ping -c 4 <target>` | "This is Kali's IP on the lab network. I ping Metasploitable and get replies, so the lab is connected." |
| 2:30-3:10 | Terminal: Linux commands (`ls -la`, `chmod 600 file`, `apt list --installed \| head`, `netstat -tulnp`) | "A few Linux basics I practised: listing files, changing permissions with chmod, package management with apt, and checking listening ports with netstat." |
| 3:10-3:50 | Wireshark capture with ping + `icmp` filter | "I started a Wireshark capture on the Host-Only interface, pinged the target, and filtered for ICMP. You can see the echo request and reply." |
| 3:50-4:25 | Terminal: `bash openssl-demo.sh` or the AES and SHA-256 commands | "For cryptography I used OpenSSL. I encrypted and decrypted a message with AES-256, generated an RSA key pair, and showed that changing one character completely changes the SHA-256 hash." |
| 4:25-4:50 | Nmap scan: `nmap -sV <target>` and DVWA in browser | "I also tested Nmap for service detection and opened DVWA, which I'll use for web security testing in later tasks." |
| 4:50-5:00 | GitHub repo page | "All notes, the Linux cheat-sheet and the report are on my GitHub. Thank you for watching." |

**Tips**
- Speak slowly, and zoom the terminal font so it is readable.
- Do not show passwords other than the lab defaults.
- Keep it between 4:30 and 5:30 minutes.
- Add the title: "ApexPlanet Cybersecurity Internship - Task 1: Foundation & Lab Setup" and the hashtags #ApexPlanet #Cybersecurity #EthicalHacking.
