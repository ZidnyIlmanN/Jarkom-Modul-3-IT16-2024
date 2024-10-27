```bash
#!/bin/bash

# 1. Konfigurasi DHCP Server (Tybur)
apt update
apt install -y isc-dhcp-server
echo "
default-lease-time 1800;
max-lease-time 5220;
option domain-name-servers [IP Fritz];

subnet [prefix IP].1.0 netmask 255.255.255.0 {
  range [prefix IP].1.5 [prefix IP].1.25;
  range [prefix IP].1.50 [prefix IP].1.100;
  default-lease-time 1800;
}

subnet [prefix IP].2.0 netmask 255.255.255.0 {
  range [prefix IP].2.9 [prefix IP].2.27;
  range [prefix IP].2.81 [prefix IP].2.243;
  default-lease-time 360;
}
" > /etc/dhcp/dhcpd.conf
systemctl restart isc-dhcp-server

# 2. Konfigurasi DNS Server (Fritz)
apt install -y bind9
echo "
options {
  directory \"/var/cache/bind\";
  forwarders { 8.8.8.8; };
  dnssec-validation auto;
  listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options
systemctl restart bind9

# 3. Deployment Docker Image untuk Kaum Eldia
apt install -y docker.io
systemctl start docker
docker pull danielcristh0/debian-buster:1.1
docker run -d --name EldiaWorker danielcristh0/debian-buster:1.1

# 4. Konfigurasi Virtual Host untuk Worker PHP (Armin)
apt install -y apache2 php7.3
echo "
<VirtualHost *:80>
  ServerName bangsaeldia.com
  DocumentRoot /var/www/eldia
  <Directory /var/www/eldia>
    AllowOverride All
  </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/eldia.conf
a2ensite eldia.conf
systemctl restart apache2

# 5. Install Apache Benchmark untuk Load Testing
apt install -y apache2-utils

# 6. Menambahkan Keamanan dengan Autentikasi di Colossal
apt install -y apache2-utils
mkdir -p /etc/nginx/supersecret
htpasswd -cb /etc/nginx/supersecret/htpasswd arminannie jrkmyyy
systemctl restart nginx