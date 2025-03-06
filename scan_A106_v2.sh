# a compléter, ne fonctionne pas car je ne lis pas correctemetn les fichiers 

nmap -oG /tmp/scantcp.txt 172.16.0.0/24
nmap -oG /tmp/scanudp.txt -sU -F 172.16.0.0/24


rm /tmp/scan-result_2.csv
echo "IP;TCP-ports;UDP-ports" > /tmp/scan-result_2.csv
#awk '/Up$/{print $2}' /tmp/scan-g.txt

fichiertcp="/tmp/scantcp.txt"
fichierudp="/tmp/scanudp.txt"

# Boucle qui lit chaque ligne du fichier
while read ligne
do
  # Vérifier si la ligne contient "tcp"
  if echo "$ligne" | grep -q "tcp"; then
    ip=$(echo "$ligne" | awk '{print $2}')
    port_counttcp=$(echo "$ligne" | grep -o "open/tcp" | wc -l)
    port_countudp=$(echo "$ligne" | grep -o "/udp" | wc -l)
    

    if [ $port_counttcp -gt 0 ]; then
      if [ $port_countudp -gt 0 ]; then
        echo "$ip;$port_counttcp;$port_countudp" >> /tmp/scan-result_2.csv
      fi
    fi
  fi
done < "$fichier"
