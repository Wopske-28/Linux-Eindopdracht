install_rsyslog:
  pkg.installed:
    - pkgs:
      - rsyslog
      - apache2
      - mysql-server-5.7
      - php
      - libapache2-mod-php

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