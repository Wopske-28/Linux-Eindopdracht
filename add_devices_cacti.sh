register cacti device:
  cmd.run:
    - name: 'php -q /usr/share/cacti/cli/add_device.php --description="Log Client 3" --ip="10.0.0.34" --avail=snmp --ping_method=udp --ping_port="23" --ping_retries=2 --version=3 --port=161 --timeout=2000 --username="authPrivUser" --password="password" --authproto="MD5" --privpass="password" --privproto="DES"'
root@J:/srv/salt# 
root@J:/srv/salt# cat add_devices_cacti.sh 
#! /bin/bash

salt '*' state.apply

#Verkrijg minion names door te greppen op een salt interface query zodat alleen het ID number blijft. Hierna, haal alle newlines weg. Vervang daarna alle ':' door spaties.
minionName="$(salt '*' network.interface eth0 | pcregrep -M "^\S.*" | tr -d '\n' | sed -e 's/:/ /g')"

#Verkrijg de minion lokale ip door een inteface query. Zet alles op één line en grep alleen het ip adres. Zet ook hier weer het resultaat op één line en vervang 'address:' door een spatie en
 strip alle leading spaces. Zo blijven alleen de ip addressen over. 
address="$(sudo salt '*' network.interface eth0 | tr -d '\n' | xargs | grep -P -o "address: \d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\d" | tr -d '\n' | sed -e 's/address: / /g' | sed -e 's/^ //g')"

#Maak een array van addressen die later gebruik kan worden in de loop.
addressArr=(${address}) 

#Enumerator
count=0

#Voor iedere minion, voeg een grafiek toe met de naam van de minion en het ip adres van de minion.
for name in $minionName
do 
cd /usr/share/cacti/cli
php -q add_device.php --description="$name" --ip="${addressArr[$count]}" --template=3 --avail=snmp --ping_method=tcp --ping_port="23" --ping_retries=2 --version=3 --port=161 --timeou
t=2000 --username="authPrivUser" --password="password" --authproto="MD5" --privpass="password" --privproto="DES"
((count++))
done

#Krijg alle Cacti host id's en grep alleen de id's eruit. 
idlist="$(php -q add_graphs.php --list-hosts | pcregrep -M -o '^\d{1,3}' | tr '\n' ' ')"

#Voor iedere minion, maak een een grafiek van de unix proccessen.
for id in $idlist
do
php -q add_graphs.php --graph-type=cg --graph-template-id=1 --host-id=$id
done