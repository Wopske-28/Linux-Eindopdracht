base:
  'kooijwordpress*':
    - server-wordpress
    - client-rsyslog
  'kooijdocker*':
    - server-docker
    - client-rsyslog
  'kooijrsyslog*':
    - server-rsyslog
  'kooijlog*':
    - server-cacti
    - client-rsyslog
  '*':
    - client-snmp

