nmap -oG /tmp/scan.txt 172.16.0.0/24

rm /tmp/scan-result_1.csv
echo "IP;TCP-ports" > /tmp/scan-result_1.csv
#awk '/Up$/{print $2}' /tmp/scan-g.txt

fichier="/tmp/scan.txt"

# Boucle qui lit chaque ligne du fichier
while read ligne
do
  # Vérifier si la ligne contient "tcp"
  if echo "$ligne" | grep -q "tcp"; then
    ip=$(echo "$ligne" | awk '{print $2}')
    port_count=$(echo "$ligne" | grep -o "open/tcp" | wc -l)
    

    if [ $port_count -gt 0 ]; then
      echo "$ip;$port_count" >> /tmp/scan-result_1.csv
    fi
  fi
done < "$fichier"
