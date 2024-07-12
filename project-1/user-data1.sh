#!/bin/bash

apt update
apt install -y apache2

cat <<EOF > /var/www/html/index.html
<h1>hello server 1 </h1>
EOF

systemctl start apache2
systemctl enable apache2