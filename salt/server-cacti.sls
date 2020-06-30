install cacti and dependencies:
  pkg.installed:
    - pkgs:
      - apache2
      - pcregrep
      - mysql-server-5.7
      - php
      - libapache2-mod-php

Connect to mysql:  
  cmd.run:
    - name: 'mysql -u root -p'

Restart mysql:
  cmd.run:
    - name: 'service mysql restart'
       
install snmpd and snmp:
  pkg.installed: 
    - pkgs:
      - snmp
      - snmpd
      - rrdtool
      - cacti
      - cacti-spine

Restart snmpd:
  cmd.run:
    - name: 'service snmpd restart'

Restart mysql again:
  cmd.run:
    - name: 'service mysql restart'

Restart apache2:
  cmd.run:
    - name: 'service apache2 restart'
