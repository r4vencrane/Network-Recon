<h1 align="center">
 Network Recon – Fast & Clean Nmap Wrapper
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Bash-Script-green?style=for-the-badge&logo=gnubash" />
  <img src="https://img.shields.io/badge/Nmap-Wrapper-blueviolet?style=for-the-badge" />
  <img src="https://img.shields.io/badge/HTB-Ready-orange?style=for-the-badge" />
</p>

---

# Network-Recon
![image](https://github.com/user-attachments/assets/b025b547-a108-4d7e-b9f3-12e19ade02d8)


##  About

**`netrecon.sh`** is a Bash-based wrapper for `nmap`, designed to perform **clean**, **automated**, and **aesthetically enhanced** network scans.

This tool is ideal for:
-  CTF players and HTB enthusiasts
-  Fast reconnaissance of target IPs
-  Generating ready-to-read `nmap` outputs
-  Automating part of the enumeration phase

---

## 💡 Ideal Use Case

You're tackling a new HTB machine and want a **clean, focused, and fast scan** to jumpstart your enumeration process. This tool gives you a battle-ready overview in seconds.


## Instalation

```bash
git clone https://github.com/venomcrane/Network-Recon.git
cd Network-Recon
chmod +x netrecon
./netrecon 
```

In case that you want to have this script in your own system:
```bash
sudo cp netrecon /usr/bin/netrecon
netrecon #write on any location of your Machine (inside of the $PATH)
```

## Usage 
Usually with **Hack The Box** Machines

```bash
netrecon -i <IP-Address>
```
Generates a `netScan` file where you can see the entire Nmap Scan in order to look for more information
![image](https://github.com/user-attachments/assets/15d8e163-4d97-4020-9b0d-9f4f5f0ab123)




