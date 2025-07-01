
<h1 align="center">
 Network Recon – Fast & Clean Nmap Wrapper
</h1>


<p align="center">
 <img src="https://img.shields.io/static/v1?style=for-the-badge&label=SHELL&message=Script&labelColor=0a0f0a&colorB=77ff00&logo=gnubash&logoColor=77ff00"/> 
 <img src="https://img.shields.io/static/v1?style=for-the-badge&label=HTB&message=OPTIMIZED&labelColor=0a0f0a&colorB=77ff00"/>
 <img src="https://img.shields.io/static/v1?style=for-the-badge&label=TOOL&message=RED%20TEAM&labelColor=0a0f0a&colorB=77ff00&logo=skyliner&logoColor=77ff00"/>
</p>


![image](https://github.com/user-attachments/assets/baf61c78-9a0d-4269-b2d6-65e7c960e614)




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


## Installation

```bash
git clone https://github.com/r4vencrane/Network-Recon.git
cd Network-Recon
chmod +x netrecon.sh
./netrecon.sh
```

In case that you want to have this script in your own system:
```bash
sudo cp netrecon.sh /usr/local/bin/netrecon
chmod +x /usr/local/bin/netrecon
netrecon -h
```

## Usage 

![image](https://github.com/user-attachments/assets/7093ae53-762a-41c3-931f-b858af35e5a2)



Usually with **Hack The Box** Machines

```bash
./netrecon.sh -t <IP-Address>  # Perform full TCP scan
./netrecon.sh -u <IP-Address>  # Perform full UDP scan
./netrecon.sh -h               # Show help panel
```

TCP Scan Example:
![image](https://github.com/user-attachments/assets/5d8407ee-22dc-48f3-934b-6e3467f1d8bf)

UDP SCAN Example:
![image](https://github.com/user-attachments/assets/bab3873c-5df8-40f5-8ee7-1e29c241eee3)

Depending of the type of scan that you selected, it genereates a `tcpScan.txt` or `udpScan.txt` file where you can see the entire Nmap Scan in order to look for more information

![image](https://github.com/user-attachments/assets/57d63086-5f54-40ad-96cb-4c136bacb59a)


<p align="center">
  <a href="https://github.com/r4vencrane/Network-Recon/blob/main/LICENSE">
    <img src="https://img.shields.io/static/v1?style=for-the-badge&label=LICENSE&message=MIT&labelColor=0a0f0a&colorB=77ff00"/>
  </a>
</p>





