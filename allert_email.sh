#!/bin/bash
#UTILIZZO TOP PER CONTROLLARE CPU E FREE PER LA MEMORIA 
#apt-get install mailutils per inviare email e protocollo ssmtp sudo apt install ssmtp###
max_CPU=80
max_Mem=80 #imposto la soglia da non superare , in caso contrario partirà un email
email="email" #email che riceve allert
Intervallo_tempo=60  #riportato in secondi
while true 
do  #ciclo infinito con stop manuale
        uso_CPU=$(top -n 1 -b | awk '/^%Cpu/{print $4}') #grep filtra info cpu e awk stampa valori corrispondenti uso CPU($2 modalità utente)(con $4 modalità system)
        uso_Mem=$(free |grep Mem | awk '{print $3/$2 * 100}') #grep filtra info memoria e awk stampa un rapporto in % della memoria ( mem usata/mem tot * 100)
    if (( $(echo "$uso_CPU > $max_CPU" | bc -l) )); then #facciamo un echo che compara l'utilizzo cpu con quella massimale e per fare l'operazione abbiamo bisogno di un calcolatore --> bc -l
        printf "Subject: Attenzione CPU elevata\n\nStai utilizzando troppa CPU --> $uso_CPU" | msmtp -C /home/vagrant/.msmtprc -a default email_destinatario
        #echo "Stai utilizzando troppa CPU --> $uso_CPU" | msmtp -s "Allert CPU" $email #inviamo un messaggio email con allert e percentuale di utilizzo
    fi
    if (( $(echo "$uso_Mem > $max_Mem" | bc -l) )); then #stesso echo di sopra ma con la memoria
        printf "Subject: Attenzione Mem elevata\n\nStai utilizzando troppa Memoria --> $uso_Mem" | msmtp -C /home/vagrant/.msmtprc -a default email_destinatario
        #echo "Stai utilizzando troppa Memoria --> $uso_Mem" | msmtp -s "Allert Memoria" $email
    fi
    sleep $Intervallo_tempo #mette in pausa lo script durante l'intervallo di tempo impostato
done 


#sudo apt update
#sudo apt install msmtp
#conf msmtp con nano ~/.msmtprc
#defaults
#auth           on
#tls            on
#tls_trust_file /etc/ssl/certs/ca-certificates.crt
#logfile        ~/.msmtp.log

#account live
#host           smtp.office365.com
#port           587
#from           tuoindirizzo@live.com
#user           tuoindirizzo@live.com
#password       tuapassword

#account default : live
#utilizzo questa configurazione perchè ho utilizzato un dominio live.it
#chmod 600 ~/.msmtprc do i permessi
#printf "Subject: Titolo\n\nsperiamo che funziona" | msmtp -C percorso msmtprc -a default email

##lo script deve essere eseguito da una directory che non sia quella condivisa con l'host 
