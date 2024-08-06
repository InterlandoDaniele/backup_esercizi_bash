#!/bin/bash
###verificare dischi liberi per creazione RAID###
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
###Crea RAID inserendo nome , livello e numero dischi##Utilizzare il sudo e non Root
sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=3 /dev/sdc /dev/sdd /dev/sde ###Utilizzo questi 3 dischi precedemente inseriti tramite Vagrantfile
cat /proc/mdstat ##Conferma creazione del RAID utilizzando i dischi sopra elencati
sudo mkfs.ext4 -F /dev/md0 ##creare un filesystem sull'array
sudo mkdir -p /mnt/md0 #crea punto di montaggio per collegare il nuovo filesystem
sudo mount /dev/md0 /mnt/md0 # montare il filesystem
df -h -x devtmpfs -x tmpfs ### controlla se il nuovo spazio è disponibile
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf ##step per riassemblaggio automatico all'avvio
sudo update-initramfs -u ###aggiornamento filesystem RAM iniziale
echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab #aggiungere opzioni di mount del filesystem nel file fstab per montaggio automatico all'avvio
#####QUESTO SCRIPT FUNZIONERà SOLAMENTE PER LA CREAZIONE DI UN RAID '0' CON I DISCHI IMPORTATI TRAMITE VAGRANTFILE#################################

#######################
# NOTE: COMANDO TEE SERVE PER LEGGERE UN INPUT E ALLO STESSO TEMPO MANDARLO IN OUTPUT 
#######################
###IDEA PER PARTIZIONARE UNITà PRINCIPALE CON MOUNT "/" BUSY
##avendo l'hard disk gia partizionato in sda1 con mount della root che occupa interamente la memoria#
#la mia idea era di fare un umount parziale,ovvero togliere le directory non indispensabili di sistema e 
#migrarle su un unità esterna per ricavare dello spazio sul disco da poter partizionare ulteriormente
#creare un nuovo volume logico e poter montare su quello le rimanenti directory della root
