install packages:
  pkg.installed:
    - pkgs:
      - apache2
      - mysql-server
      - mysql-client
      - php
      - libapache2-mod-php
      - php-mysql
      - wordpress

Make database:
  cmd.run:
    - names: 
      - mysql -u root -e "CREATE DATABASE wordpress;"
      - mysql -u root -e "GRANT ALL ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'root';"
      - mysql -u root -e "FLUSH PRIVILEGES" 
  

Populate directory:
  cmd.run:
    - name: cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.com.conf

Add default conf file:
  file.managed:
    - name : /etc/apache2/sites-available/wordpress.com.conf
    - source: salt://wordpress.com.conf

Enable apache2 modules:
  cmd.run:
    - names:
      - a2enmod headers
      - a2enmod env
      - a2enmod mime
      - a2enmod dir
      - a2enmod rewrite

Create wordpress site directory:
  cmd.run:
    - names:
      - mkdir -p /var/www/html/wordpress.com
      - chown -R www-data:www-data /var/www/html
      - chown -R 755 /var/www/html
      - systemctl restart apache2
      - cp /usr/share/wordpress/* /var/www/html/wordpress.com/ -r

Connect to database:
  file.line:
    - name: /var/www/html/wordpress.com/wp-config.php
    - match: "    define('DB_USER', 'wordpress');"
    - content: "define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'root');"
    - mode: "replace"

Restart apache2:
  cmd.run:
    - name: systemctl restart apache2