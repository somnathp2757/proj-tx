#!/bin/bash
apt-get update -y
apt-get install nginx -y
systemctl start nginx
systemctl enable nginx

#Create one file with configuration content in server at 
#/etc/nginx/sites-available 
#If available default config file then delete 
sudo ln -s /etc/nginx/sites-available/lb  /etc/nginx/sites-enabled/
#Copy the data into file present in sites-enabled 

cat <<'EOF' | base64 -d > /etc/nginx/sites-available/lb
<dXBzdHJlYW0gYmFja2VuZCB7CiAgICBzZXJ2ZXIgYmFja2VuZC1zZXJ2ZXItMTsKICAgIHNlcnZl
ciBiYWNrZW5kLXNlcnZlci0yOwogICAgIyBBZGQgbW9yZSBzZXJ2ZXJzIGlmIG5lZWRlZAp9Cgpz
ZXJ2ZXIgewogICAgbGlzdGVuIDgwOwogICAgc2VydmVyX25hbWUgeW91cl9kb21haW5fb3Jfc2Vy
dmVyX2lwOwoKICAgICMgUmVkaXJlY3QgSFRUUCB0byBIVFRQUwogICAgcmV0dXJuIDMwMSBodHRw
czovLyRob3N0JHJlcXVlc3RfdXJpOwp9CgpzZXJ2ZXIgewogICAgbGlzdGVuIDQ0MyBzc2w7CiAg
ICBzZXJ2ZXJfbmFtZSB5b3VyX2RvbWFpbl9vcl9zZXJ2ZXJfaXA7CgogICAgc3NsX2NlcnRpZmlj
YXRlIC9ldGMvbmdpbngvc3NsL3lvdXJfZG9tYWluLmNydDsKICAgIHNzbF9jZXJ0aWZpY2F0ZV9r
ZXkgL2V0Yy9uZ2lueC9zc2wveW91cl9kb21haW4ua2V5OwoKICAgICMgQWRkIFNTTCBjb25maWd1
cmF0aW9ucyBhcyBuZWVkZWQgKGUuZy4sIHNzbF9wcm90b2NvbHMsIHNzbF9jaXBoZXJzLCBldGMu
KQoKICAgIGxvY2F0aW9uIC8gewogICAgICAgIHByb3h5X3Bhc3MgaHR0cDovL2JhY2tlbmQ7CiAg
ICAgICAgcHJveHlfc2V0X2hlYWRlciBIb3N0ICRob3N0OwogICAgICAgIHByb3h5X3NldF9oZWFk
ZXIgWC1SZWFsLUlQICRyZW1vdGVfYWRkcjsKICAgICAgICBwcm94eV9zZXRfaGVhZGVyIFgtRm9y
d2FyZGVkLUZvciAkcHJveHlfYWRkX3hfZm9yd2FyZGVkX2ZvcjsKICAgICAgICBwcm94eV9zZXRf
aGVhZGVyIFgtRm9yd2FyZGVkLVByb3RvICRzY2hlbWU7CiAgICB9Cn0KCg==
>
EOF

nginx -t
systemctl reload nginx
