#!/bin/bash
curl --request GET \
    --url https://www.virustotal.com/api/v3/ip_addresses/$1 \
    --header 'x-apikey: <API-KEY>'
