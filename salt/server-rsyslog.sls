install rsyslog server:
  pkg.installed:
    - pkgs:
      - rsyslog

deploy rsyslog conf file:
  file.managed:
    - name: /etc/rsyslog.d/01-logserver.conf
    - source: salt://01-logserver.conf

Allow firewall 514:
  cmd.run:
    - name: ufw allow 514

Allow firewall 514 tcp:
  cmd.run:
    - name: ufw allow 514/tcp

Allow firewall 514 udp:
  cmd.run:
    - name: ufw allow 514/udp
    
Watch rsyslog conf:
  service.running:
    - name: rsyslog
    - enable: true
    - reload: true
    - watch:
      - file: /etc/rsyslog.d/01-logserver.conf

Restart rsyslog:
  cmd.run:
    - name: sudo systemctl restart rsyslog
