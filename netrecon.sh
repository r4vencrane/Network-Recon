#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Ctrl+C 
function ctrl_c(){
  echo -e "\n\n${redColour}[+] Leaving...${endColour}\n"
  exit 1
}

trap ctrl_c INT


banner="${greenColour}$(cat << "EOF"                                                                                                                                 


         _______          __                       __     __________                            
         \      \   _____/  |___  _  _____________|  | __ \______   \ ____   ____  ____   ____  
         /   |   \_/ __ \   __\ \/ \/ /  _ \_  __ \  |/ /  |       _// __ \_/ ___\/  _ \ /    \ 
        /    |    \  ___/|  |  \     (  <_> )  | \/    <   |    |   \  ___/\  \__(  <_> )   |  \
        \____|__  /\___  >__|   \/\_/ \____/|__|  |__|_ \  |____|_  /\___  >\___  >____/|___|  /
                \/     \/                              \/         \/     \/     \/           \/  [v 1.0] 
                                             -=[ by r4venn ]=-                                        


EOF
)${endColour}"


# Función de Spinner
function spinner(){
  local SPIN=("◐" "◓" "◑" "◒")
  local i=0
  while true; do 
    echo -ne "\r[${SPIN[i]}] $1"
    ((i=(i+1)%4))
    sleep 0.1
  done
}

scan_ip(){
  ip_address="$1"
  echo -e "$banner"  
  echo -e "\n========================================================================================================="
  echo -e "                                              Network Scanner "
  echo -e "=========================================================================================================\n"
  echo -e "[+] ${grayColour}Scanning IP Address${endColour} : ${greenColour}$ip_address${endColour}\n"

  echo -e "[*] ${grayColour}Performing TCP Network Scanning...${endColour1}"
  spinner "${grayColour}Scanning Ports...${endColour}" &
  SPINNER_PID=$!

  # Escaneo rápido
  nmap -p- --open -sS --min-rate 5000 -n -Pn "$ip_address" -oG initScan &>/dev/null

  kill "$SPINNER_PID" &>/dev/null  # Detener el spinner
  echo -ne "\r[✔] ${grayColour}Port Scan Completed.${endColour}        \n\n"

  # Extraer puertos abiertos
  ports="$(grep -oP '\d{1,5}/open' initScan | awk -F'/' '{print $1}' | xargs | tr ' ' ',')"

  if [ -n "$ports" ]; then
    echo -e "[+] ${grayColour}IP${endColour}: ${greenColour}$ip_address${endColour} \n[+] ${grayColour}Open Ports:${endColour} ${greenColour}$ports${endColour}" | boxes -d stone

    echo -e "\n[*] ${grayColour}Obtaining detailed information on services...${endColour}"
    spinner "${grayColour}Scanning Services...${endColour}" &
    SPINNER_PID=$!

    # Escaneo detallado
    nmap -sCV -p"$ports" -n -Pn "$ip_address" -oN netScan.txt &>/dev/null

    kill "$SPINNER_PID" &>/dev/null
    echo -ne "\r[✔] ${grayColour}Services Scan Completed${endColour}.     \n"

    echo -e "\n${purpleColour}====================================== [::] TCP Full Scan Summary [::] ================================${endColour}\n"
    grep -E "^[0-9]+/tcp" netScan.txt | while read -r line; do
      port=$(echo "$line" | awk '{print $1}' | cut -d'/' -f1)
      service=$(echo "$line" | awk '{print $3}')
      version=$(echo "$line" | cut -d' ' -f4-)
      echo -e "   [+] ${grayColour}Port${endColour} ${greenColour}$port${endColour}: ${purpleColour}$service${endColour}, ${turquoiseColour}$version${endColour}" 
    done

    # Mover esta parte fuera del while
    echo -e "\n[+] ${grayColour}File generated after Scanning${endColour}: ${greenColour}netScan.txt${endColour}"
    echo -e "[+]${purpleColour} View Nmap File for more information${endColour}: ${greenColour}cat netScan.txt -l java${endColour}"
    rm initScan

  else
    echo -e "${redColour}[!] No open ports were found in $ip_address${endColour}"
  fi
}

# Función de ayuda
function helpPanel(){
  echo -e "$banner"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Usage:${endColour} \n\t${purpleColour}./netrecon.sh [options] [arguments]${endColour}"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Options:${endColour}"
  echo -e "  ${blueColour}-i${endColour} ${purpleColour}<IP>${endColour}     ➜ ${grayColour}Specifies the IP to scan${endColour}"
  echo -e "  ${blueColour}-h${endColour}          ➜ ${grayColour}Show Help Panel${endColour}"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Examples:${endColour}"
  echo -e "\t  ${greenColour}netrecon.sh -i 10.10.10.248${endColour}"
  echo -e "\t${greenColour}./netrecon.sh -i 10.10.10.248${endColour}"
  

}

# Indicadores
declare -i paremeter_counter=0 

while getopts "i:h" arg; do 
  case $arg in 
    i) ip_address=$OPTARG; let paremeter_counter+=1;;
    h) helpPanel; exit 0;;
    ?) helpPanel; exit 1;;
  esac
done

if [ $paremeter_counter -eq 1 ]; then
  scan_ip "$ip_address"
else
  helpPanel
fi



