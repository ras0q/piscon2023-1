#!/bin/bash

sudo cp ../common/etc/nginx/nginx.conf /etc/nginx/nginx.conf

cd ../app/go && go build -o isucari

sudo systemctl restart isucari.golang.service
