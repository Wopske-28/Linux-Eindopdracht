register cacti device:
  cmd.run:
    - name: 'php -q /usr/share/cacti/cli/add_device.php --description="Log Client 3" --ip="10.0.0.34" --avail=snmp --ping_method=udp --ping_port="23" --ping_retries=2 --version=3 --port=161 --timeout=2000 --username="authPrivUser" --password="password" --authproto="MD5" --privpass="password" --privproto="DES"'