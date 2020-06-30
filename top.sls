base:
  'kooijwordpress':
    - server-wordpress
  'kooijdocker':
    - server-docker
  'kooijrsyslog':
    - server-rsyslog
  'kooijlog':
    - server-cacti
  '*':
    - client-snmp
    - client-rsyslog

