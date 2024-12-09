# Jarkom-Modul-3-IT16-2024

| Nama          | NRP          |
| ------------- | ------------ |
| Zidny Ilman Nafi'an | 5027221072 |
| MUHAMMAD DZAKWAN | 5027201065 |

## Topologi
![image](https://github.com/user-attachments/assets/5c666d1f-6e19-4458-9d88-44dc505a71dc)

## Config
Config setiap node

### Paradis (DHCP Relay)

```markdown
auto eth0
iface eth0 inet dhcp
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.237.0.0/16
up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
	address 192.237.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.237.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.237.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.237.4.1
	netmask 255.255.255.0
```

### Tybur (DHCP Server)

```markdown
auto eth0
iface eth0 inet static
address 192.237.4.2
netmask 255.255.255.0
gateway 192.237.4.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Fritz (DNS Server)

```markdown
auto eth0
iface eth0 inet static
address 192.237.4.3
netmask 255.255.255.0
gateway 192.237.4.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Warhammer (database)

```markdown
auto eth0
iface eth0 inet static
address 192.237.3.2
netmask 255.255.255.0
gateway 192.237.3.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Beast (LoadBalancer Laravel)

```markdown
auto eth0
iface eth0 inet static
address 192.237.3.4
netmask 255.255.255.0
gateway 192.237.3.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf

```

### Colossal (LoadBalancer PHP)

```markdown
auto eth0
iface eth0 inet static
address 192.237.3.3
netmask 255.255.255.0
gateway 192.237.3.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Annie (Laravel Worker)

```markdown
auto eth0
iface eth0 inet static
address 192.237.1.2
netmask 255.255.255.0
gateway 192.237.1.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf

```

### Bertholdt (Laravel Worker)

```markdown
auto eth0
iface eth0 inet static
address 192.237.1.3
netmask 255.255.255.0
gateway 192.237.1.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf

```

### Reiner (Laravel Worker)

```markdown
auto eth0
iface eth0 inet static
address 192.237.1.4
netmask 255.255.255.0
gateway 192.237.1.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Armin (PHP Worker)

```markdown
auto eth0
iface eth0 inet static
address 192.237.2.2
netmask 255.255.255.0
gateway 192.237.2.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Eren (PHP Worker)

```markdown
auto eth0
iface eth0 inet static
address 192.237.2.3
netmask 255.255.255.0
gateway 192.237.2.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Mikasa (PHP Worker)

```markdown
auto eth0
iface eth0 inet static
address 192.237.2.4
netmask 255.255.255.0
gateway 192.237.2.1
up echo nameserver 192.237.4.3 > /etc/resolv.conf
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Zeke (Client)

```markdown
auto eth0
iface eth0 inet dhcp
```

### Erwin (Client)

```markdown
auto eth0
iface eth0 inet dhcp

```

## Nomor 0
Membuat script di Fritz agar domain [marley.it08.com](http://marley.it08.com) ke IP Annie dan [eldia.it08.com](http://eldia.it08.com) ke IP Armin

```markdown
apt-get update
apt-get install bind9 -y

forward="options {
directory \"/var/cache/bind\";
forwarders {
  	   192.168.122.1;
};

allow-query{any;};
listen-on-v6 { any; };
};
"
echo "$forward" > /etc/bind/named.conf.options

echo "zone \"marley.it08.com\" {
	type master;
	file \"/etc/bind/jarkom/marley.it08.com\";
};

zone \"eldia.it08.com\" {
	type master;
	file \"/etc/bind/jarkom/eldia.it08.com\";
};
" > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

riegel="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    marley.it08.com. root.marley.it08.com. (
        2        ; Serial
                604800        ; Refresh
                86400        ; Retry
                2419200        ; Expire
                604800 )    ; Negative Cache TTL
;                   
@    IN    NS    marley.it08.com.
@       IN    A    192.237.1.2
"
echo "$riegel" > /etc/bind/jarkom/marley.it08.com

granz="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    eldia.it08.com. root.eldia.it08.com. (
        2        ; Serial
                604800        ; Refresh
                86400        ; Retry
                2419200        ; Expire
                604800 )    ; Negative Cache TTL
;                   
@    IN    NS    eldia.it08.com.
@       IN    A    192.237.2.2
"
echo "$granz" > /etc/bind/jarkom/eldia.it08.com

service bind9 restart
```

## Nomor 1 - 5
- Menjalankan service dari isc-dhcp-server di Tybur

```markdown
service isc-dhcp-server start
```

- Menambahkan line berikut pada file /etc/default/isc-dhcp-server di Tybur

```markdown
INTERFACES="eth0"
```

- Membuat script untuk menghubungkan Paradis ke Tybur

```markdown
echo INTERFACESv4="eth0" > /etc/default/isc-dhcp-server

echo 'authoritative;

subnet 192.237.3.0 netmask 255.255.255.0 {
    option routers 192.237.3.0;
    option broadcast-address 192.237.3.255;
}

subnet 192.237.4.0 netmask 255.255.255.0 {
    option routers 192.237.4.0;
    option broadcast-address 192.237.4.255;
}

subnet 192.237.1.0 netmask 255.255.255.0 {
    range 192.237.1.5 192.237.1.25;
    range 192.237.1.50 192.237.1.100;
    option routers 192.237.1.1;
    option broadcast-address 192.237.1.255;
    option domain-name-servers 192.237.4.1;
    default-lease-time 1800;
    max-lease-time 5220;
}

subnet 192.237.2.0 netmask 255.255.255.0 {
    range 192.237.2.9 192.237.2.27;
    range 192.237.2.81 192.237.2.243;
    option routers 192.237.2.1;
    option broadcast-address 192.237.2.255;
    option domain-name-servers 192.237.4.1;
    default-lease-time 360;
    max-lease-time 5220;
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
```

Test pada client
![Screenshot 2024-10-27 212306](https://github.com/user-attachments/assets/d7ba0b1d-bc32-4077-b8fe-6a0971e93db0)
![Screenshot 2024-10-27 212356](https://github.com/user-attachments/assets/1b270234-e03c-4cc9-9f3c-44592b1537df)

## Nomor 6

Menjalankan script di bawah ini kepada node PHP Worker (Armin, Eren, Mikasa) dan mengeceknya menggunakan `lynx localhost`.

```
#/bin/bash

wget 'https://drive.usercontent.google.com/u/0/uc?id=1RCy_7ptfsGXQ8_HJ8-28tts1a3EpnBlQ&export=download' -O modul3.zip
unzip modul3.zip
mkdir -p /var/www/eldia
mv modul-3/* /var/www/eldia

cat <<EOF >> /etc/nginx/sites-available/eldia.it08.com
server {
     listen 80;
     server_name _;

     root /var/www/eldia;
     index index.php index.html index.htm;

     location / {
         try_files $uri $uri/ /index.php?$query_string;
     }

     location ~ \.php$ {
         include snippets/fastcgi-php.conf;
         fastcgi_pass unix:/run/php/php7.3-fpm.sock;
         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
         include fastcgi_params;
     }
}
EOF

ln -s /etc/nginx/sites-available/eldia.it08.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart
```
**Hasil**
![image](https://github.com/user-attachments/assets/2d39ecb6-d9c0-4420-8220-31b20bd49a0d)
![image](https://github.com/user-attachments/assets/f6564c31-b479-417c-af25-9ab8884aa39c)
![image](https://github.com/user-attachments/assets/c6a5b710-68a6-4307-bb2d-eebb40dd5a94)

## Nomor 7

Membuat script untuk menginstalasi dependencies dan mengonfigurasi Nginx sebagai load balancer dengan IP worker yang ditentukan

```
#!/bin/bash

# Update repositories
echo "Updating package repositories..."
apt-get update

# Install dependencies
echo "Installing lynx, nginx, php7.0, and php-fpm..."
apt-get install -y lynx nginx php7.0 php7.0ab -n 6000 -c 200 http://192.237.3.3/-fpm apache2-utils

# Start php-fpm and nginx services
echo "Starting php7.0-fpm and nginx services..."
service php7.0-fpm start
service nginx start

# Define NGINX load balancer configuration
NGINX_CONF="/etc/nginx/sites-available/load-balancer-it08.conf"
echo "Creating nginx load balancer configuration at $NGINX_CONF..."

cat <<EOL > $NGINX_CONF
upstream worker {
	server 192.237.2.2; # IP Armin
	server 192.237.2.3; # IP Eren
	server 192.237.2.4; # IP Mikasa
}

server {
	listen 80;

	root /var/www/html;

	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		proxy_pass http://worker;  # Mengarahkan ke grup upstream worker
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection 'upgrade';
		proxy_set_header Host $host;
		proxy_cache_bypass $http_upgrade;
	}
}
EOL

# Enable the new configuration
echo "Creating symlink for load balancer configuration..."
ln -s $NGINX_CONF /etc/nginx/sites-enabled/load-balancer-it08

# Remove default configuration
echo "Removing default nginx configuration..."
rm /etc/nginx/sites-enabled/default

# Restart services
echo "Restarting nginx and php7.0-fpm services..."
service nginx restart
service php7.0-fpm restart

echo "Load balancer setup complete."
```

Tes di client dengan `ab -n 6000 -c 200 http://eldia.it08.com/`
![Screenshot 2024-10-27 230813](https://github.com/user-attachments/assets/b7c65d6a-fd6c-4332-bd97-322434c1a4c2)
![Screenshot 2024-10-27 230824](https://github.com/user-attachments/assets/b30e641d-56c2-46fc-8704-7fdb6c079cd1)

## Nomor 8
Untuk nomor 8, kita hanya perlu menjalankan script nomor 7 namun dengan mengganti algoritma load balancernya menjadi Round Robin (default), IP Hash, Generic Hash, dan Least Connection. Pada setiap algoritmanya, kita perlu menjalankan `ab -n 1000 -c 75 http://eldia.it08.com/`. Berikut adalah grafik RPS tiap algoritma:

![image](https://github.com/user-attachments/assets/e68f8e24-590e-4057-93e8-df861f12dfc0)

Untuk analisis, dapat dicek di [pdf](https://github.com/Rrrrein/Jarkom-Modul-3-IT08-2024/blob/main/IT08_LaporanArmin.pdf) yang berada di dalam repo.

## Nomor 9
Sama halnya dengan nomor 8, kita menggunakan algoritma Least Connection dengan mengurangi jumlah workernya seperti berikut ini:

3 worker (default)
```
upstream worker {
  server 192.237.2.2; # IP Armin
  server 192.237.2.3; # IP Eren
  server 192.237.2.4; # IP Mikasa
}
```

2 worker
```
upstream worker {
  server 192.237.2.2; # IP Armin
  server 192.237.2.3; # IP Eren
  # server 192.237.2.4; # IP Mikasa
}
```

1 worker
```
upstream worker {
  server 192.237.2.2; # IP Armin
  # server 192.237.2.3; # IP Eren
  # server 192.237.2.4; # IP Mikasa
}
```

Berikut adalah grafiknya, RPS tertinggi berada pada saat 1 worker saja yang bekerja.

![image](https://github.com/user-attachments/assets/40dfbfbf-62bc-413f-9773-f9f3bc96fa0f)

Grafik ini juga dapat dilihat di dalam [pdf](https://github.com/Rrrrein/Jarkom-Modul-3-IT08-2024/blob/main/IT08_LaporanArmin.pdf).

## Nomor 10
Menjalankan script berikut untuk menambahkan username `arminannie` dan password `jrkmit08`

```
#/bin/bash

mkdir /etc/nginx/supersecret
htpasswd -c -b /etc/nginx/supersecret/.htpasswd arminannie jrkmit08

rm -f /etc/nginx/sites-available/lb_php

cat <<EOF >> /etc/nginx/sites-available/lb_php
upstream worker {
  server 192.237.2.2; # IP Armin
  server 192.237.2.3; # IP Eren
  server 192.237.2.4; # IP Mikasa
}

server {
        listen 80;
        server_name _;

        location / {
          proxy_pass http://worker;
          auth_basic "Restricted Access";
          auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
        }
}
EOF

rm -f /etc/nginx/sites-enabled/lb_php
ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

service nginx restart
```

**Hasil**
![image](https://github.com/user-attachments/assets/8d4d9ac2-39ee-407c-80ba-f1dae4e82f9a)
![image](https://github.com/user-attachments/assets/19ebde0e-b696-4947-b03a-57daaa049d0c)
![image](https://github.com/user-attachments/assets/e1f9c385-f30f-4de3-b6d7-1fe0ae5b7432)

## Nomor 11

Menjalankan script berikut dan test menggunakan `lynx eldia.it08.com/titan`.

```
#!/bin/bash

rm -f /etc/nginx/sites-available/lb_php

cat <<EOF >> /etc/nginx/sites-available/lb_php
upstream worker {
    server 192.237.2.2;
    server 192.237.2.3;
    server 192.237.2.4;
}

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
    }

    location /titan {
        proxy_pass https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki;
        proxy_set_header Host attackontitan.fandom.com;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

rm -f /etc/nginx/sites-enabled/lb_php
ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

service nginx restart
```

**Hasil**
![image](https://github.com/user-attachments/assets/ef2c4085-bf9f-45dc-ac34-0cd77adfaf61)

## Nomor 12

Menjalankan script berikut agar dapat diakses dengan IP khusus.

```
#!/bin/bash

rm -f /etc/nginx/sites-available/lb_php

cat <<EOF >> /etc/nginx/sites-available/lb_php
upstream worker {
    server 192.237.2.2;
    server 192.237.2.3;
    server 192.237.2.4;
}

server {
    listen 80;
    server_name _;

    location / {
        allow 192.237.1.77;
        allow 192.237.1.88;
        allow 192.237.2.144;
        allow 192.237.2.156;
        deny all;
        proxy_pass http://worker;
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
    }

    location /titan {
        proxy_pass https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki;
        proxy_set_header Host attackontitan.fandom.com;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

rm -f /etc/nginx/sites-enabled/lb_php
ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

service nginx restart
```

Di sini kami menentukan Zeke menjadi client tetapnya, setelah itu masukkan script berikut ke dalam Tybur (DHCP Server).

```
host Zeke {
   hardware ethernet 92:6a:4b:8f:b3:cf;
   fixed-address 192.237.1.88;
}
```
**Hasil**

Jika diakses selain menggunakan client Zeke, maka Colossal tidak dapat diakses.

![image](https://github.com/user-attachments/assets/025913f9-caff-4d37-bbb0-566c79f219a8)


## Nomor 13

Menjalankan script berikut pada node Warhammer.

```
#!/bin/bash

cat <<EOF >> /etc/mysql/my.cnf
[mysqld]
skip-networking=0
skip-bind-address
EOF

mysql -e "CREATE USER 'it08'@'%' IDENTIFIED BY 'it08';"
mysql -e "CREATE USER 'it08'@'marley.it08.com' IDENTIFIED BY 'it08';"
mysql -e "CREATE DATABASE db_it08;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'it08'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'it08'@'marley.it08.com';"
mysql -e "FLUSH PRIVILEGES;"

service mysql restart
```

Kemudian test pada worker Laravel (Annie, Bertholdt, Reiner) dengan perintah `mariadb --host=192.237.3.2 --port=3306 --user=it08 --password=it08 db_it08 -e "SHOW DATABASES;"`

**Hasil**

![image](https://github.com/user-attachments/assets/8bf6c70a-5df6-443a-b12a-b35ca3fefb1e)

