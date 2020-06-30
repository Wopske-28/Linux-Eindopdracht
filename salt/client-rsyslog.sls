install_rsyslog:
  pkg.installed:
    - pkgs:
      - rsyslog

deploy 50-conf file:
  file.managed:
    - name: /etc/rsyslog.d/50-default.conf
    - source: salt://50-default.conf

deploy conf file:
  file.managed:
    - name: /etc/rsyslog.conf
    - source: salt://rsyslog.conf

Watch rsyslog conf:
  service.running:
    - name: rsyslog
    - enable: true
    - reload: true
    - watch:
      - file: /etc/rsyslog.d/50-default.conf

Restart rsylog service:  
  cmd.run:
    - name: sudo systemctl restart rsyslog 
