#!/bin/bash
#####SCRIPT CREAZIONE,FORMATTAZIONE E MOUNT LVM SU BASE DI 3 PARTIZIONE DA 5GB ESISTENTI TRAMITE VAGRANTFILE#########
#3.times {|i| config.vm.disk :disk, size: "5GB", name: "drive-#{i}"}  #DA INSERIRE IN VAGRANTFILE PER AVERE 3 PARTI DA 5GB##
pvcreate /dev/sdd /dev/sdc /dev/sde
vgcreate Prova1 /dev/sdd /dev/sdc /dev/sde
lvcreate -L 1GB -n Lv1 Prova1 -y
mkfs.ext4 /dev/Prova1/Lv1 
mount -t ext4 /dev/Prova1/Lv1 /mnt
echo "LVM montata con successo --> /mnt"

#####è possibile lavorare ad un "umount" parziale del filesystem se ho un disco busy e non ho possibilità di montarne altri?
#l'idea è smontare dalla root i percorsi non indispensabili e lasciare quelli per far girare il sistema
#(mantenere /bin /sbin /etc /usr /var) smontare e migrare i rimanenti, migrarli su un flash disk
#dallo spazio ricavato creare una nuova partizione logica e rimontare il tutto li
#C'è FATTIBILITà????####################################à
