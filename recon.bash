#!/bin/bash
TODAY=$(date)
echo "This scan was created on $TODAY"
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY

nmap_scan()
{
 nmap $DOMAIN > $DIRECTORY/nmap
 echo "The results of nmap scan are stored in $DIRECTORY/nmap."
}

dirsearch_scan()
{
 dirsearch -u $DOMAIN -e php --format plain -o $DIRECTORY/dirsearch.txt
 echo "The results of dirsearch scan are stored in $DIRECTORY/dirsearch.txt."
}

crt_scan()
{
 curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt
 echo "The results of cert parsing are stored in $DIRECTORY/crt."
}

case $2 in
 nmap-only)
 nmap_scan
 ;;
 dirsearch-only)
 dirsearch_scan
 ;;
 crt-only)
 crt_scan
 ;;
 *)
nmap_scan
 dirsearch_scan
 crt_scan
 ;;
esac
