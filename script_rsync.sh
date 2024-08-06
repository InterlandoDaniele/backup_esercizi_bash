#!/bin/bash
#$1 prende l'input esternamente directory da backuppare
#sudo apt-get install rsync  #INSTALLAZIONE RSYNC --> GIà PRESENTE ALL'AVVIO SCRIPT###
rsync -aAXv $1 /vagrant  # -a riporta tutte le condizioni originali del file dalla destinazione alla sorgente come timestamp, link simbolici, permessi, proprietario e gruppo
#-A preserva access control lists -X preserva attributi -v mostra progressi a video
#Nel mio caso l'unità esterna è il mio sistema host quindi la cartella condivisa Vagrant , ma basta sostituire il percorso con quello di un unità esterna se a disposizione
#--progress flag per vedere i progressi in fase di backup
echo "Backup eseguito su /vagrant"
####Funzione ripristino backup