#!/bin/bash
#   yum -y install nginx
#   echo "<h1>nginx WebServer<h1>" > /usr/share/nginx/html/index.html)
#   systemctl enable --now nginx.service)
#   service enable
#   firewalld start
#   SELinux
yum -y install nginx \
    && echo "<h1>nginx WebServer</h1>" > /usr/share/nginx/html/index.html \
    && systemctl restart nginx \
    && echo "[ OK ] nginx Web Server started."