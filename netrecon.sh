#!/bin/bash


# ========== Colores (negrita + nombres descriptivos) ==========
# --- Colores normales ---
blackColour='\033[1;38;5;0m'      # #0a0f0a (negro oscuro)
redColour='\033[1;38;5;1m'        # #ff0059 (rojo intenso)
greenColour='\033[1;38;5;2m'       # #00ff41 (verde neón)
yellowColour='\033[1;38;5;3m'      # #b3ff00 (amarillo verdoso)
blueColour='\033[1;38;5;4m'        # #00b3ff (azul eléctrico)
purpleColour='\033[1;38;5;5m'      # #bb00ff (morado vibrante)
turquoiseColour='\033[1;38;5;6m'        # #00ffd2 (cian brillante)
grayColour='\033[1;38;5;7m'       # #d9e0ee (blanco suave)

# --- Colores brillantes ---
strongGray='\033[1;38;5;8m'        # #262a2e (gris oscuro)
lightRedColour='\033[1;38;5;9m'    # #ff477f (rosa fluorescente)
limaColour='\033[1;38;5;10m'  # #77ff00 (verde limón)
lightYellowColour='\033[1;38;5;11m' # #ccff00 (amarillo puro)
lightBlueColour='\033[1;38;5;12m'   # #33ccff (azul cielo)
lightPurpleColour='\033[1;38;5;13m' # #ff77ff (rosa chicle)
lightCyanColour='\033[1;38;5;14m'   # #00ffff (cian encendido)
brightWhiteColour='\033[1;38;5;15m' # #ffffff (blanco puro)

# --- Reset ---
endColour='\033[0m'



#Ctrl+C 
function ctrl_c(){
  echo -e "\n\n${redColour}[+] Leaving...${endColour}\n"
  exit 1
}

trap ctrl_c INT


banner="${turquoiseColour}$(cat << "EOF"                                                                                                                                 

         _______          __                       __     __________                            
         \      \   _____/  |___  _  _____________|  | __ \______   \ ____   ____  ____   ____  
         /   |   \_/ __ \   __\ \/ \/ /  _ \_  __ \  |/ /  |       _// __ \_/ ___\/  _ \ /    \ 
        /    |    \  ___/|  |  \     (  <_> )  | \/    <   |    |   \  ___/\  \__(  <_> )   |  \
        \____|__  /\___  >__|   \/\_/ \____/|__|  |__|_ \  |____|_  /\___  >\___  >____/|___|  /
                \/     \/                              \/         \/     \/     \/           \/   
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

tcp_scan(){
  command -v boxes >/dev/null 2>&1 || { echo -e "${redColour}[!] boxes not present. Install with: sudo apt install boxes${endColour}"; exit 1; }
  ip_address="$1"
  echo -e "$banner"  
  echo -e "\n========================================================================================================="
  echo -e "                                              Network Scanner "
  echo -e "=========================================================================================================\n"
  echo -e "[+] ${grayColour}Scanning IP Address${endColour} : ${greenColour}$ip_address${endColour}\n"

  echo -e "[*] ${grayColour}Performing TCP Network Scanning...${endColour}"
  spinner "${grayColour}Scanning Ports...${endColour}" &
  SPINNER_PID=$!

  # Escaneo rápido
  nmap -p- --open -sS --min-rate 5000 -n -Pn "$ip_address" -oG tcpScan &>/dev/null

  kill "$SPINNER_PID" &>/dev/null  # Detener el spinner
  echo -ne "\r[✔] ${grayColour}Port Scan Completed.${endColour}        \n\n"

  # Extraer puertos abiertos
  ports="$(grep -oP '\d{1,5}/open' tcpScan | awk -F'/' '{print $1}' | xargs | tr ' ' ',')"

  if [ -n "$ports" ]; then
    echo -e "[+] ${grayColour}IP${endColour}: ${greenColour}$ip_address${endColour} \n[+] ${grayColour}Open Ports:${endColour} ${greenColour}$ports${endColour}" | boxes -d stone

    echo -e "\n[*] ${grayColour}Obtaining detailed information on services...${endColour}"
    spinner "${grayColour}Scanning Services...${endColour}" &
    SPINNER_PID=$!

    # Escaneo detallado
    nmap -sCV -p"$ports" -n -Pn "$ip_address" -oN tcpScan.txt &>/dev/null

    kill "$SPINNER_PID" &>/dev/null
    echo -ne "\r[✔] ${grayColour}Services Scan Completed${endColour}.     \n"

    echo -e "\n${purpleColour}====================================== [::] TCP Full Scan Summary [::] ================================${endColour}\n"
    grep -E "^[0-9]+/tcp" tcpScan.txt | while read -r line; do
      port=$(echo "$line" | awk '{print $1}' | cut -d'/' -f1)
      service=$(echo "$line" | awk '{print $3}')
      version=$(echo "$line" | cut -d' ' -f4-)
      echo -e "   [+] ${grayColour}Port${endColour} ${greenColour}$port${endColour}: ${purpleColour}$service${endColour}, ${turquoiseColour}$version${endColour}" 
    done

    # Mover esta parte fuera del while
    echo -e "\n[+] ${grayColour}File generated after Scanning${endColour}: ${greenColour}tcpScan.txt${endColour}"
    echo -e "[+]${purpleColour} View Nmap File for more information${endColour}: ${greenColour}cat tcpScan.txt -l java${endColour}"
    rm tcpScan

  else
    echo -e "${redColour}[!] No open ports were found in $ip_address${endColour}"
  fi
}

udp_scan(){
  command -v boxes >/dev/null 2>&1 || { echo -e "${redColour}[!] boxes not present. Install with: sudo apt install boxes${endColour}"; exit 1; }
  ip_address="$1"
  echo -e "$banner"  
  echo -e "\n========================================================================================================="
  echo -e "                                              Network Scanner "
  echo -e "=========================================================================================================\n"
  echo -e "[+] ${grayColour}Scanning IP Address${endColour} : ${greenColour}$ip_address${endColour}\n"

  echo -e "[*] ${grayColour}Performing UDP Network Scanning...${endColour1}"
  spinner "${grayColour}Scanning Ports...${endColour}" &
  SPINNER_PID=$!

  # Escaneo rápido
  nmap -sU --top-ports 1000 --open --min-rate 5000 --max-retries 1 -n -Pn -oG udpScan "$ip_address" &>/dev/null


  kill "$SPINNER_PID" &>/dev/null  # Detener el spinner
  echo -ne "\r[✔] ${grayColour}Port Scan Completed.${endColour}        \n\n"

  # Extraer puertos abiertos
  ports=$(grep -oP '\d{1,5}/open' udpScan | cut -d'/' -f1 | tr '\n' ',' | sed 's/,$//')


  if [ -n "$ports" ]; then
    echo -e "[+] ${grayColour}IP${endColour}: ${greenColour}$ip_address${endColour} \n[+] ${grayColour}Open Ports:${endColour} ${greenColour}$ports${endColour}" | boxes -d stone

    echo -e "\n[*] ${grayColour}Obtaining detailed information on services...${endColour}"
    spinner "${grayColour}Scanning Services...${endColour}" &
    SPINNER_PID=$!

    # Escaneo detallado
    nmap -sU -p "$ports" -sV --version-intensity 5 --script=default,discovery,safe -n -Pn -oN udpScan.txt "$ip_address" &>/dev/null

    kill "$SPINNER_PID" &>/dev/null
    echo -ne "\r[✔] ${grayColour}Services Scan Completed${endColour}.     \n"

    echo -e "\n${purpleColour}====================================== [::] UDP Full Scan Summary [::] ================================${endColour}\n"
    grep -E "^[0-9]+/udp" udpScan.txt | while read -r line; do
      port=$(echo "$line" | awk '{print $1}' | cut -d'/' -f1)
      service=$(echo "$line" | awk '{print $3}')
      version=$(echo "$line" | cut -d' ' -f4-)
      echo -e "   [+] ${grayColour}Port${endColour} ${greenColour}$port${endColour}: ${purpleColour}$service${endColour}, ${turquoiseColour}$version${endColour}" 
    done

    # Mover esta parte fuera del while
    echo -e "\n[+] ${grayColour}File generated after Scanning${endColour}: ${greenColour}udpScan.txt${endColour}"
    echo -e "[+]${purpleColour} View Nmap File for more information${endColour}: ${greenColour}cat udpScan.txt -l java${endColour}"
    rm udpScan

  else
    echo -e "${redColour}[!] No open ports were found in $ip_address${endColour}"
  fi

}

# Función de ayuda
function helpPanel(){
  echo -e "$banner"
  echo -e "${limaColour}\n========================================================================================================="
  echo -e "                                                Help Panel "
  echo -e "=========================================================================================================${endColour}"
  echo -e "\n${limaColour}[+]${endColour} ${grayColour}Usage:${endColour} \n\t${turquoiseColour}./netrecon.sh [options] [arguments]${endColour}"
  echo -e "\n${limaColour}[+]${endColour} ${grayColour}Options:${endColour}"
  echo -e "  ${turquoiseColour}-t${endColour} ${purpleColour}<IP>${endColour}     ➜ ${grayColour}Perform Full TCP Scan${endColour}"
  echo -e "  ${turquoiseColour}-u${endColour} ${purpleColour}<IP>${endColour}     ➜ ${grayColour}Perform UDP Scan${endColour}"
  echo -e "  ${turquoiseColour}-h${endColour}          ➜ ${grayColour}Show Help Panel${endColour}"
  echo -e "\n${limaColour}[+]${endColour} ${grayColour}Examples:${endColour}"
  echo -e "\t${greenColour}./netrecon.sh -t 10.10.10.248${endColour}"
  echo -e "\t${greenColour}./netrecon.sh -u 10.10.10.248${endColour}"
  

}

# Indicadores
declare -i paremeter_counter=0 

while getopts "t:u:h" arg; do 
  case $arg in 
    t) ip_address=$OPTARG; let paremeter_counter+=1;;
    u) ip_address=$OPTARG; let paremeter_counter+=2;;
    h) helpPanel; exit 0;;
    ?) helpPanel; exit 1;;
  esac
done

if [ $paremeter_counter -eq 1 ]; then
  tcp_scan "$ip_address"
elif [ $paremeter_counter -eq 2 ]; then
  udp_scan "$ip_address"
  
else
  helpPanel
fi



