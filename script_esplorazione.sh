#!/bin/bash  
#inizializzazione shell bash
# Function to process a directory
##INSTALLARE PRIMA SYMLINK CON -->sudo apt install symlinks 
path=$1
tree $1 > risultato1.txt
symlinks -v $1 > /var/log/symlinks_output.log
#find -L -lname $1 > /var/log/symlinks_output.log
#find -L $1 -type l -ls > risultato2.txt