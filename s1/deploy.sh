#!/bin/bash
jk
set -aux

sudo cp ../common/etc/nginx/nginx.conf /etc/nginx/nginx.conf

export PPROTEIN_GIT_REPOSITORY="/home/isucon/piscon2023-1"
export GOROOT=""
export GOPROXY=https://proxy.golang.org,direct
cd ../app/go && go build -o isucari

# log
sudo chmod +r /var/log/mysql
sudo rm -rf /var/log/mysql/mysql-slow.log /var/log/nginx/access.log
sudo touch /var/log/mysql/mysql-slow.log /var/log/nginx/access.log
sudo chmod +r /var/log/mysql/mysql-slow.log /var/log/nginx/access.log /var/log/nginx/access.log
sudo touch /var/log/mysql/mysql-slow.log /var/log/nginx/access.log
sudo chmod +r /var/log/mysql/mysql-slow.log /var/log/nginx/access.log
sudo chown mysql:mysql /var/log/mysql/mysql-slow.log

sudo systemctl restart mysql.service
sudo systemctl restart nginx.service
sudo systemctl restart isucari.golang.service

sudo mysql -uroot -e 'SET GLOBAL long_query_time = 0; SET GLOBAL slow_query_log = ON; SET GLOBAL slow_query_log_file = "/var/log/mysql/mysql-slow.log";'

sudo journalctl -u isucari.golang.service -f
