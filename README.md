<h1 align="center">
 Network Recon – Fast & Clean Nmap Wrapper
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Bash-Script-green?style=for-the-badge&logo=gnubash" />
  <img src="https://img.shields.io/badge/Nmap-Wrapper-blueviolet?style=for-the-badge" />
  <img src="https://img.shields.io/badge/HTB-Ready-orange?style=for-the-badge" />
</p>

![image](https://github.com/user-attachments/assets/ccdb51df-9c6b-4321-9599-08fdd188d87c)

---

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

![image](https://github.com/user-attachments/assets/ab983657-b838-47f5-92e9-dc9a6a449e8b)


Usually with **Hack The Box** Machines

```bash
netrecon -i <IP-Address>
```
Generates a `netScan` file where you can see the entire Nmap Scan in order to look for more information


![image](https://github.com/user-attachments/assets/f7448da5-665a-4534-8cf2-1df95a87cc0a)






