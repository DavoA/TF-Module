#!/bin/bash
sudo apt update
sudo apt install nginx -y
echo "my instance in ${visibility} subnet" > /var/www/html/index.html
sudo service nginx restart