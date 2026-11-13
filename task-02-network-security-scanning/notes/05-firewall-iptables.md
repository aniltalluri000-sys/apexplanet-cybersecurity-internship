# 05. Firewall Basics (iptables)

iptables is the classic Linux packet filter. Rules are checked top to bottom in a **chain**; the first match decides.

| Chain | Traffic |
|---|---|
| INPUT | Packets coming **to** this machine |
| OUTPUT | Packets leaving this machine |
| FORWARD | Packets routed through this machine |

Targets: `ACCEPT` (allow), `DROP` (silently discard), `REJECT` (discard and tell the sender).

## Demonstration on Metasploitable2 (the machine being scanned)

Log in as `msfadmin` (password `msfadmin`) and use `sudo`.

1. **Baseline (from Kali):** `sudo nmap -p 80 192.168.56.103` shows `80/tcp open http`.
2. **Block port 80 (on Metasploitable):**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 80 -j DROP
   sudo iptables -L -n --line-numbers
   ```
3. **Scan again (from Kali):** `sudo nmap -p 80 192.168.56.103` now shows `80/tcp filtered http`. Also try the browser: the DVWA page no longer loads.
4. **Remove the rule:**
   ```bash
   sudo iptables -D INPUT -p tcp --dport 80 -j DROP
   ```

## Allow only SSH, drop the rest (optional)

```bash
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -j DROP
```

Scan from Kali: only port 22 is open and everything else is filtered. **Undo it afterwards** so the lab works again:
```bash
sudo iptables -F
```

## Blocking a port-scan attempt

Rate-limit new connections so a fast scan is slowed or dropped:
```bash
sudo iptables -A INPUT -p tcp --syn -m limit --limit 5/second --limit-burst 10 -j ACCEPT
sudo iptables -A INPUT -p tcp --syn -j DROP
```
Run `sudo nmap -sS 192.168.56.103` from Kali. The scan becomes much slower and shows more filtered ports. Reset with `sudo iptables -F`.

If `-m limit` or `-m state` is not supported by the old Metasploitable kernel, use the simple DROP rule above, or apply the same rules on Kali and scan Kali from another machine.

## Notes

- iptables rules are lost on reboot unless saved (`iptables-save`), which is useful for a lab: reboot clears them.
- Modern replacement: `nftables` / `ufw` (`sudo ufw deny 80/tcp`).
- DROP makes scanners wait (port shows `filtered`); REJECT answers immediately (port shows `closed`).
