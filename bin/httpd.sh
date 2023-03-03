#!/bin/bash
#   httpd web server install
#   package install
#   server setting
#   service enable
#   firewalld start
#   SELinux
yum -y install httpd 
    && echo "<h1>httpd WebServer</h1>" > /var/www/html/index.html \
    && service httpd restart \
    && echo "[ OK ] Apache HTTPD Web Server started."

# curl localhost