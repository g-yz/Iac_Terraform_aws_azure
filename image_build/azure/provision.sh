#!/bin/bash
set -e

# Detect default user (UID 1000)
DEFAULT_USER=$(getent passwd 1000 | cut -d: -f1)
echo "Detected default user: $DEFAULT_USER"

# Update and enable universe repo
apt-get update
apt-get install -y software-properties-common
add-apt-repository universe
apt-get update

# Install core tools
apt-get install -y curl gnupg2 ca-certificates lsb-release net-tools build-essential

# Optional: for SSL with Let's Encrypt
apt-get install -y certbot python3-certbot-nginx

# Install Node.js 14
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
apt-get install -y nginx

# Install PM2 v5 (last version fully compatible with Node 14)
npm install -g pm2@5

# Move app into place
mkdir -p /opt/app
mv /tmp/server.js /opt/app/server.js

# Start Node.js app with PM2 under detected user
sudo -i -u "$DEFAULT_USER" bash <<EOF
pm2 start /opt/app/server.js --name node-app >> /var/log/pm2-start.log 2>&1
pm2 save
EOF

# Set PM2 to launch on boot
sudo env PATH=$PATH:/usr/bin:/bin:/usr/local/bin pm2 startup systemd -u "$DEFAULT_USER" --hp /home/"$DEFAULT_USER"

# Move Nginx config into place
mv /tmp/node_production.conf /etc/nginx/sites-available/node_production
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/node_production /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

# Generate self-signed cert for testing
mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/selfsigned.key \
  -out /etc/nginx/ssl/selfsigned.crt \
  -subj "/C=US/ST=NA/L=NA/O=NA/CN=localhost"
nginx -t && systemctl reload nginx

# Add certbot renewal cron job
echo '0 0 * * * root certbot renew --quiet' > /etc/cron.d/certbot-renew
