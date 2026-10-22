# Linux Cheat-Sheet (Kali / Debian)

## File System Navigation

| Command | Purpose |
|---|---|
| `pwd` | Print current directory |
| `ls`, `ls -la` | List files (all, long format) |
| `cd /path`, `cd ..`, `cd ~`, `cd -` | Change directory (absolute, up, home, previous) |
| `mkdir -p a/b/c` | Create nested directories |
| `touch file.txt` | Create empty file / update timestamp |
| `cp -r src dst` | Copy (recursive for directories) |
| `mv old new` | Move or rename |
| `rm file`, `rm -r dir` | Delete (no recycle bin, be careful) |
| `cat`, `less`, `head -n 5`, `tail -f log` | View file contents |
| `find / -name "*.conf" 2>/dev/null` | Search by name |
| `grep -rin "password" /etc 2>/dev/null` | Search inside files |
| `locate name` | Fast search (run `updatedb` first) |

Important directories: `/etc` configs, `/var/log` logs, `/home` users, `/tmp` temp, `/usr/bin` programs, `/root` root's home.

## File and Directory Permissions

```
-rwxr-xr-- 1 user group 1024 Oct 18 file.sh
 |||||||||
 |||||||++-- others: r--
 ||||+++---- group:  r-x
 |+++------- owner:  rwx
 +---------- type (- file, d directory, l link)
```

Values: r = 4, w = 2, x = 1.

| Command | Meaning |
|---|---|
| `chmod 755 file` | rwx for owner, r-x for group and others |
| `chmod 644 file` | rw- owner, r-- others |
| `chmod 600 key.pem` | owner only (private keys) |
| `chmod +x script.sh` | make executable |
| `chmod -R 750 dir` | recursive |
| `chown user:group file` | change owner and group |
| `chown -R user dir` | recursive |
| `umask` | default permission mask |

Special: `sudo` run as root, `su - user` switch user, `id` show uid/gid/groups, `whoami`.

## Package Management

| Command | Purpose |
|---|---|
| `sudo apt update` | Refresh package lists |
| `sudo apt upgrade` | Upgrade installed packages |
| `sudo apt install nmap` | Install |
| `sudo apt remove nmap` / `purge` | Remove (purge also deletes config) |
| `apt search wireshark` | Search |
| `apt show nmap` | Package details |
| `dpkg -i package.deb` | Install a local .deb |
| `dpkg -l | grep nmap` | List installed |
| `dpkg -L nmap` | Files installed by a package |
| `dpkg -r package` | Remove |

## Networking Commands

| Command | Purpose |
|---|---|
| `ifconfig` / `ip a` | Show interfaces and IPs |
| `ip route` | Routing table |
| `ping -c 4 host` | Test reachability (ICMP) |
| `netstat -tulnp` / `ss -tulnp` | Listening ports and owning processes |
| `traceroute host` | Path to a host |
| `nslookup domain` / `dig domain` | DNS lookup |
| `arp -a` | ARP table |
| `curl -I http://host` | Fetch HTTP headers |
| `wget URL` | Download a file |
| `ssh user@host` | Remote shell |
| `scp file user@host:/path` | Copy over SSH |

## Processes and System

```bash
ps aux | grep apache      # find processes
top / htop                # live usage
kill PID / kill -9 PID    # stop a process
systemctl status ssh      # service status
sudo systemctl start|stop|restart|enable ssh
df -h                     # disk usage
free -h                   # memory
uname -a                  # kernel info
history                   # command history
```

## Text and Redirection

```bash
cmd > out.txt      # overwrite
cmd >> out.txt     # append
cmd 2> err.txt     # stderr
cmd1 | cmd2        # pipe
sort | uniq -c     # count unique lines
wc -l file         # count lines
cut -d: -f1 /etc/passwd
awk '{print $1}' file
sed 's/old/new/g' file
```

## Handy Hashing / Encoding

```bash
echo -n "hello" | sha256sum
md5sum file
base64 file / base64 -d
```

## Keyboard Shortcuts

`Ctrl+C` stop, `Ctrl+Z` suspend, `Ctrl+L` clear, `Ctrl+R` search history, `Tab` autocomplete.
