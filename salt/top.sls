base:
  'kooijwordpress*':
    - server-wordpress
    - client-rsyslog
  'kooijdocker*':
    - server-docker
    - client-rsyslog
  'kooijsyslog*':
    - server-rsyslog
  'kooijcacti*':
    - server-cacti
    - client-rsyslog
  '*':
    - client-snmp

