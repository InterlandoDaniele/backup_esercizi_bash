#!/bin/bash
#dpkg-query -l iotop > /dev/null
#case $? in
#	0) echo iotop è già installato;;
#	1) sudo apt-get install iotop -y;;
#esac
#if ! command -v iotop &> /dev/null  ###controlla se c'è lo strumento altrimenti installalo
#then
#    sudo apt-get update -y
#    sudo apt-get install iotop -y
#fi
#tempo_monitoraggio=10
#sudo iotop -b -n $tempo_monitoraggio | awk '{print $0}' > /home/vagrant/risultato_IO.txt
#sudo iotop --only -n $tempo_monitoraggio | awk '{print $0}' > /home/vagrant/risultato_IO.txt
#echo "troverai il risultato su /home/vagrant"

#opzione uno vmstat 1 10
#opzione due df -h
#opzione tre vmstat -d #### ( se aggiungo es. 1 10 ripete l'operazione ogni secondo per 10 secondi)####

####UTILIZZANDO SAR###############################################################
####QUI SOTTO CONTROLLIAMO E INSTALLIAMO SYSSTAT#####################
#dpkg-query -l sysstat > /dev/null
#case $? in
#	0) echo sysstat è già installato;;
#	1) sudo apt install sysstat -y;;
#esac
#if ! command -v sysstat &> /dev/null  ###controlla se c'è lo strumento altrimenti installalo
#then
#    sudo apt-get update -y
#    sudo apt install sysstat -y
#fi
#cat <<EOF > /etc/default/sysstat  ####ABILITA SERVIZIO DA SYSSTAT#######
#  GNU nano 6.2                /etc/default/sysstat                          #
# Default settings for /etc/init.d/sysstat, /etc/cron.d/sysstat
# and /etc/cron.daily/sysstat files
#

# Should sadc collect system activity informations? Valid values
# are "true" and "false". Please do not put other values, they
# will be overwritten by debconf!
#ENABLED="true"
#EOF
#systemctl restart sysstat.service  #######riavvia servizi
sar -b | awk '{print $0}' > /home/vagrant/RISULTATO_SAR_IO  ##	PRIMA DI POTER LANCIARE QUESTO COMANDO VA CONFIGURATA L'ABILITAZIONE SU SYSSTAT##
###################################################################################################################


