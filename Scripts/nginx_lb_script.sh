#!/bin/bash
#installing nginx
apt-get update -y
apt-get install nginx -y
systemctl start nginx
systemctl enable nginx

#Create one file with configuration content in server at /etc/nginx/sites-available 
rm -rf /etc/nginx/sites-enabled/default

#If available default config file then delete 
sudo ln -s /etc/nginx/sites-available/lb  /etc/nginx/sites-enabled/
#Copy the data into file present in sites-enabled 
echo 'upstream backend {
    server backend-server-1;
    server backend-server-2;
    # Add more servers if needed
}
server {
    listen 80;
    server_name your_domain_or_server_ip;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name your_domain_or_server_ip;

    ssl_certificate /etc/nginx/ssl/your_domain.crt;
    ssl_certificate_key /etc/nginx/ssl/your_domain.key;

    # Add SSL configurations as needed (e.g., ssl_protocols, ssl_ciphers, etc.)

    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
' > /etc/nginx/sites-available/lb
nginx -t
systemctl reload nginx

