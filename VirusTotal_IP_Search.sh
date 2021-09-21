#!/bin/bash
# A curl GET request to fetch json data on the IP address I submit.
# ./VirusTotal_IP_Search.sh "<IP address>"
curl --request GET \
    --url https://www.virustotal.com/api/v3/ip_addresses/$1 \
    --header 'x-apikey: <API-KEY>'
