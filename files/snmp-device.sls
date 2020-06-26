install_snmpd_requirements:
  pkg.installed:
    - pkgs:
      - snmpd
      - apache2
      - mysql-server-5.7
      - php
      - libapache2-mod-php

Restart snmpd service:
  service.running:
    - name: snmpd
    - reload: true
    - watch:
      - file: /etc/snmp/snmpd.conf

Block localhost listing:
  file.line:
    - name: /etc/snmp/snmpd.conf
    - content: "#agentAddress  udp:127.0.0.1:161"
    - match: "agentAddress  udp:127.0.0.1:161"
    - mode: "replace"

Listen on all given ports:
  file.line:
   - name: /etc/snmp/snmpd.conf
   - content: "agentAddress udp:161,udp6:[::1]:161"
   - match: "#agentAddress udp:161,udp6:[::1]:161"
   - mode: "replace"

Default access to system:
  file.line:
    - name: /etc/snmp/snmpd.conf
    - content: "rocommunity secret  10.0.0.0/16"
    - match: "#rocommunity secret  10.0.0.0/16"
    - mode : "replace"

Create user:
  file.line:
    - name: /etc/snmp/snmpd.conf
    - content: "  createUser authPrivUser  MD5 \"{{ pillar['cactipswd'] }}\" DES \"{{ pillar['cactipswd'] }}\"" 
    - match: "createUser authOnlyUser  MD5 \"remember to change this password\""
    - mode: "replace"

Full RW access for user:
  file.line:
    - name: /etc/snmp/snmpd.conf
    - content: "rwuser   authPrivUser   priv"
    - match: "rwuser   authPrivUser   priv"
    - mode: "replace"

Allow port 161/tcp:
  cmd.run:
    - name: 'ufw allow 161/tcp'

Allow port 161/udp:
  cmd.run:
    - name: 'ufw allow 161/udp'

Allow port 23:
  cmd.run:
    - name: 'ufw allow 23/tcp'

Retart systemctl service:
  cmd.run:
    - name: 'systemctl restart snmpd'