base:
  'kooijwordpress':
    - wordpress-server
  'kooijdocker':
    - docker-engine-helloworld
  'kooijrsyslog':
    - rsyslog-server
  'kooijlog':
    - cacti-server-setup
  '*':
    - snmp-device
    - rsyslog-setup

