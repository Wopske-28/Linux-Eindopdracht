install_rsyslog:
  pkg.installed:
    - pkgs:
      - rsyslog

deploy conf file:
  file.managed:
    - name: /etc/rsyslog.d/01-custom.conf
    - source: salt://01-custom.conf

Restart service:
  service.running:
    - name: rsyslog
    - enable: true
    - reload: true
    - watch:
      - file: /etc/rsyslog.d/01-custom.conf
  cmd.run:
    - name: 'systemctl restart rsyslog' 