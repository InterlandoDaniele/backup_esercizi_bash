#!/bin/bash

apt install haproxy -y  #INSTALLAZIONE

haproxy -v   #VERIFICA VERSIONE

###### https://www.haproxy.org/ ##### CONTROLLO ULTIMA VERSIONE RILASCIATA ###########

add-apt-repository ppa:vbernat/haproxy-2.9 -y  #AGGIORNAMENTO A ULTIMA VERSIONE

apt update  #AGGIORNAMENTO REPOSITORY

apt install haproxy=2.9.\* -y  #INSTALLAZIONE DA REPOSITORY

haproxy -v  #VERIFICA NUOVAMENTE VERSIONE

systemctl status haproxy  #VERIFICARE STATO SERVIZIO HAPROXY.SERVICE

systemctl enable haproxy  #ABILITà AVVIO AUTOMATICO AL RIAVVIO SO

cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bk  #BACKUP PRIMA DI MODIFICARE CONFIGURAZIONE

cat <<EOF > /etc/haproxy/haproxy.cfg   #EDIT CONFIGURAZIONE  


global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon
        maxconn 4096

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http


frontend haproxynode
   bind *:8081
   mode http
   default_backend webserver
backend webserver
   balance roundrobin
   server tomcat 127.0.0.1:8080 check
listen stats
   bind 127.0.0.1:8181
   stats enable
   stats uri /
   stats refresh 5s
   stats realm Haproxy\ Statistics
   stats auth tomcat:tomcat
EOF

sudo systemctl restart haproxy  #RIAVVIO IL SERVIZIO


