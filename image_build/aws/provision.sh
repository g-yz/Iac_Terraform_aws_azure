#!/bin/bash
set -e

# Ensure system is up to date and universe repo is enabled
apt-get update
apt-get install -y software-properties-common
add-apt-repository universe
apt-get update  # again after adding universe

# Install core tools
apt-get install -y curl gnupg2 ca-certificates lsb-release net-tools build-essential

# Optional: for SSL with Let's Encrypt
apt-get install -y certbot python3-certbot-nginx

# Install Node.js 14.x
curl -sL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
apt-get install -y nginx

# Install PM2 globally
npm install -g pm2

# Move app into place
mkdir -p /opt/app
mv /tmp/server.js /opt/app/server.js


# Start Node.js app with PM2 (log to file)
# Start Node.js app and save under 'ubuntu'
sudo -i -u ubuntu bash <<EOF
pm2 start /opt/app/server.js --name node-app >> /var/log/pm2-start.log 2>&1
pm2 save
EOF

# Set PM2 to launch on boot (actually apply it)
sudo env PATH=$PATH:/usr/bin:/bin:/usr/local/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu

# Move Nginx config into place
mv /tmp/node_production.conf /etc/nginx/sites-available/node_production
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/node_production /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx


mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/selfsigned.key \
  -out /etc/nginx/ssl/selfsigned.crt \
  -subj "/C=US/ST=NA/L=NA/O=NA/CN=localhost"
nginx -t && systemctl reload nginx


# Add certbot renewal job (optional, domain needed post-deploy)
echo '0 0 * * * root certbot renew --quiet' > /etc/cron.d/certbot-renew
