base:
  'kooijwordpress*':
    - server-wordpress
    - client-rsyslog
  'kooijdocker*':
    - server-docker
    - client-rsyslog
  'kooijsyslog*':
    - server-rsyslog
  'kooijlog*':
    - server-cacti
    - client-rsyslog
  '*':
    - client-snmp

