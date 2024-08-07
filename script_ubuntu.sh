#!/bin/bash
apt update
apt install -y openjdk-21-jre-headless  #Y per confermare i cambiamenti
groupadd tomcat 
useradd -s /bin/false -g tomcat -d /home/tomcat tomcat
apt install -y unzip wget    #Y per confermare i cambiamenti
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83.tar.gz
tar xzvf apache-tomcat-8.5.83.tar.gz
mv apache-tomcat-8.5.83 /opt/tomcat
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh
cat <<EOF > /etc/systemd/system/tomcat.service  
# scrivere quanto segue nel file tomcat.service              
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF
#cat <<EOF >  /opt/tomcat/conf/tomcat-users.xml 
#<?xml version="1.0" encoding="UTF-8"?>
#<!--
#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
##
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#-->
#<tomcat-users xmlns="http://tomcat.apache.org/xml"
#              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
#              version="1.0">
#<!--
#  By default, no user is included in the "manager-gui" role required
#  to operate the "/manager/html" web application.  If you wish to use this app,
#  you must define such a user - the username and password are arbitrary.
#
#  Built-in Tomcat manager roles:
#    - manager-gui    - allows access to the HTML GUI and the status pages
#    - manager-script - allows access to the HTTP API and the status pages
#    - manager-jmx    - allows access to the JMX proxy and the status pages
#    - manager-status - allows access to the status pages only
#
#  The users below are wrapped in a comment and are therefore ignored. If you
#  wish to configure one or more of these users for use with the manager web
#  application, do not forget to remove the <!.. ..> that surrounds them. You
#  will also need to set the passwords to something appropriate.
#-->
#<!--
#  <user username="admin" password="<must-be-changed>" roles="manager-gui"/>
#  <user username="robot" password="<must-be-changed>" roles="manager-script"/>
#-->
#<!--
#  The sample user and role entries below are intended for use with the
#  examples web application. They are wrapped in a comment and thus are ignored
#  when reading this file. If you wish to configure these users for use with the
#  examples web application, do not forget to remove the <!.. ..> that surrounds
#  them. You will also need to set the passwords to something appropriate.
#-->
#<!--
#  <role rolename="tomcat"/>
#  <role rolename="role1"/>
#  <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
#  <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
#  <user username="role1" password="<must-be-changed>" roles="role1"/>
#-->
#  <role rolename="manager-gui"/>
#  <role rolename="manager-script"/>
#  <user username="zets" password="admin" roles="manager-gui, manager-script"/>
#</tomcat-users>
#
#EOF
#UTENZA ID zets PASS admin

chmod -R 755 /opt/tomcat

systemctl daemon-reload

systemctl enable tomcat.service

systemctl start tomcat.service

