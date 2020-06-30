Server bestanden:
	- server-cacti.sls
		Zet de cacti server op. Maakt eerste een connectie met een database door 'mysql -u root -p' uit te voeren waarna cacti deze connectie kan gebruiken.
	- server-docker.sls
		Zet de docker server op. Installeerd alle benodigheden om docker te kunnen uitvoeren. Maakt tevens gebruik van een open-source image die een simpele html pagina laat zien
		met daarop 'Hello world!'
	- server-wordpress.sls
		Zet de wordpress server op. Maakt eerst een database op voor de wordpress site en geeft alle rechten voor de website.
		Installeerd alle benodigde apche2 modules, zorgt ervoor dat /var/www de rechten krijgt over de files van de website zodat apache2 deze kan runnen.
		Deze .sls file noemt het pad naar de webiste ip-to-site/wordpress.com.

Client bestanden:
	- client-rsyslog.sls
		Zet clients op zodat ze automatisch verbinden met de rsyslog server. Deze .sls file maakt gebruik van de managed 50-default.conf file en de rsyslog.conf manged file.
		Alle IP's in beide managed files moet veranderd worden naar het IP van de rsyslog server.
		
		(Ik heb samen met Paul Koning gewerkt aan het werkend krijgen van de syslog clients. We kwamen erachter dat als we in 50-default.conf niet alle file input facilities 
		 filteren zodat lokaal niet de logs ook worden verwerkt de syslog vol wordt gespammed in een loop. Ook hebben we geprobeerd gewoon *.* @@server-ip te doen om gewoon 
		 alle log files te versturen, dit werkt echter niet omdat er niks ontvangen wordt op de server.)

	- client-snmp.sls
		Zet clients op zodat snmp wordt geinstalleerd wordt. Hierna wordt snmp zo opgezet dat de juiste users en wachtwoorden worden gebruik om met de cacti database te 
		kunnen verbinden.

Manged-files:
	- 01-logserver.conf
		Zorgt ervoor dat de logserver naar incoming tcp messages op poort 514 gaat luisteren. De files die ontvangen worden in /var/log/%HOSTNAME% opgeslagen.
	- 50-default.conf
		Zorgt ervoor dat niet lokaal ook nog eens de syslog opgeslagen wordt wat een 'vol spamming' van het syslog bestand voorkomt. (Mijn syslog bestand was zonder dit te doen binnen een half uur
		meer dan 25GB groot.)
	- rsyslog.conf
		Pakt de /var/log/syslog file en voegt deze toe aan InputFileFacility local 3. Hij polled iedere 10 seconden de file en verstuurd deze naar het IP van de rsyslogserver.

Bash bestanden:
	- add_devices_cacti.sh
		Voert eerst een high-state uit zodat alles correct geinstalleerd is. Hierna worden alle IP addressen van alle minions gepakt en wordt hier overheen gelooped. Iedere minion wordt toegevoegd als 
		device aan cacti en er wordt tevens een grafiek toegevoegd voor iedere device.