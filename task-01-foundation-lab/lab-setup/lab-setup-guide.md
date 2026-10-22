# Lab Setup Guide

Goal: an isolated lab with Kali Linux (attacker) and Metasploitable2 / DVWA (targets) on a private Host-Only network.

## 1. Requirements

- 8 GB+ RAM (16 GB recommended), 60 GB+ free disk, CPU with virtualization (VT-x/AMD-V) enabled in BIOS
- VirtualBox (or VMware Workstation Player)
- Images: Kali Linux VM image (kali.org), Metasploitable2 (SourceForge)

## 2. Install VirtualBox

1. Download from virtualbox.org and install with defaults.
2. Install the Extension Pack (optional, for USB support).
3. Confirm: Help -> About shows the version. **Screenshot 1.**

## 3. Create the Host-Only network

1. VirtualBox -> File -> Tools -> Network Manager -> Host-only Networks -> Create.
2. Typical settings: IPv4 `192.168.56.1`, mask `255.255.255.0`. DHCP server enabled is fine.
3. **Screenshot 2:** Host-only network settings.

## 4. Kali Linux (attacker)

1. Import the Kali VirtualBox image (File -> Import Appliance) or create a new VM from the ISO (2 CPU, 4 GB RAM, 40 GB disk).
2. Adapter 1: **NAT** (internet for updates). Adapter 2: **Host-Only Adapter**.
3. Boot, log in, then update:
   ```bash
   sudo apt update && sudo apt full-upgrade -y
   ```
4. Check addresses:
   ```bash
   ip a
   ```
5. **Screenshot 3:** Kali desktop with `ip a` showing the 192.168.56.x address.

## 5. Metasploitable2 (target)

1. Create a new VM: type Linux, version Ubuntu (32-bit), 512 MB RAM. Use the existing `.vmdk` disk.
2. Network: **Host-Only Adapter only** (never bridge or NAT this machine, it is intentionally vulnerable).
3. Boot, log in with `msfadmin` / `msfadmin`, then run `ifconfig` to read its IP (e.g. `192.168.56.103`).
4. **Screenshot 4:** Metasploitable login screen / `ifconfig`.

## 6. DVWA (web target)

Option A: use the DVWA instance that ships on Metasploitable2 at `http://<metasploitable-ip>/dvwa`.

Option B: install on Kali:
```bash
sudo apt install -y dvwa        # or follow the DVWA GitHub README
sudo dvwa-start                 # starts Apache + MariaDB
```
Open `http://127.0.0.1/DVWA`, click Create/Reset Database, and log in (`admin` / `password`). Set Security Level to *Low* for practice.

**Screenshot 5:** DVWA login or home page.

## 7. Verify connectivity

From Kali:
```bash
ping -c 4 192.168.56.103
nmap -sV 192.168.56.103
```
**Screenshot 6:** successful ping and Nmap output.

## 8. Wireshark test capture

1. Open Wireshark in Kali and start capturing on the Host-Only interface.
2. In a terminal: `ping -c 4 192.168.56.103`, and browse `http://192.168.56.103` once.
3. Stop the capture, apply the `icmp` and `http` filters.
4. Save as `test-capture.pcapng`.
5. **Screenshot 7:** Wireshark showing ICMP echo request/reply packets.

## 9. Snapshots

Take a VM snapshot of each machine after a clean setup so you can restore after experiments.

## 10. Safety Rules

- Keep Metasploitable on Host-Only only.
- Do not scan or attack any network you do not own.
- Never expose intentionally vulnerable machines to the internet.

## 11. Troubleshooting (issues I hit and fixed)

- **Target showed `192.168.1.x` instead of `192.168.56.x`:** the VM's adapter was not Host-Only. Shut the VM down, set Settings > Network > Adapter 1 to *Host-only Adapter*, start it again and re-check with `ifconfig`.
- **Kali had only `10.0.2.15` (no `192.168.56.x`):** Adapter 2 was not enabled. Shut Kali down, enable Adapter 2 as *Host-only Adapter*, start it again.
- **`dhclient: command not found` on Kali:** recent Kali uses NetworkManager. Use `sudo nmcli device connect eth0`, or create a persistent profile for the lab adapter:
  ```bash
  sudo nmcli connection add type ethernet ifname eth1 con-name labnet ipv4.method auto
  sudo nmcli connection up labnet
  ```
- **Check both adapters at a glance:** `ip -br a` (expect `eth0` = `10.0.2.15`, `eth1` = `192.168.56.x`).

## 12. Lab addresses used

| Machine | Adapter | Address |
|---|---|---|
| Kali Linux | eth0 (NAT) | 10.0.2.15 |
| Kali Linux | eth1 (Host-Only) | 192.168.56.101 |
| Metasploitable2 | eth0 (Host-Only) | 192.168.56.103 |
