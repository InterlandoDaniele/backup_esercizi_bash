#!/bin/bash
dpkg-query -l $1 > /dev/null  #mandare in input il nome del pacchetto da verificare ed eventualmente installare
case $? in
	0) echo $1 è già installato;;
	1) sudo apt-get install $1 -y;;
esac
if ! command -v $1 &> /dev/null  ###controlla se c'è lo strumento altrimenti installalo
then
    sudo apt-get update -y
    sudo apt-get install $1 -y
fi