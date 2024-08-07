#!/bin/bash
echo "Elenco processi in esecuzione:" #mi fa un eco con l'elenco dei processi nel sistema dettagliati
ps -ef 
read -p "Quale processo vuoi killare:" pid  #prende l'input utente e lo passa al comando kill
kill $pid 