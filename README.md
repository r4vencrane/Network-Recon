# Network-Recon
![image](https://github.com/user-attachments/assets/b025b547-a108-4d7e-b9f3-12e19ade02d8)

This script use Nmap and automates network-level scanning for open ports, normally used for HTB machines.

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




