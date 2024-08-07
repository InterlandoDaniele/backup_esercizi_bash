#!/bin/bash
report=/home/vagrant/risultato_aggiornamento.txt
echo apt-get update && apt-get upgrade -y > $report  
value=$(<$report) #prende il file e lo carica nella variabile value 
printf "Subject: Report upgrade\n\nQuesto è il report --> $value" | msmtp -C /home/vagrant/.msmtprc -a default d.interlando@consulthink.it 