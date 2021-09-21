#!/bin/bash
# ./VirusTotal_Parser.sh <file_with_ip>.txt
file=$1
while IFS= read -r line
do
	bash VirusTotal_IP_Search.sh $line > /tmp/311d2d68-9c66-4db8-b10c-a28c0af0a3b9
	tmp="/tmp/311d2d68-9c66-4db8-b10c-a28c0af0a3b9"
	asown=$(grep '"as_owner"' $tmp | awk '$1=$1')
    as=$(grep '"asn"' $tmp | awk '$1=$1')
    cont=$(grep '"continent"' $tmp | awk '$1=$1')
	count=$(grep '"country"' $tmp | awk '$1=$1')
	network=$(grep '"network"' $tmp | awk '$1=$1')
	rir=$(grep '"regional_internet_registry"' $tmp | awk '$1=$1')
	harmful=$(grep -A 3 '"last_analysis_stats"' $tmp | grep '"harmless"' | awk '$1=$1')
	mal=$(grep -A 3 '"last_analysis_stats"' $tmp | grep '"malicious"' | awk '$1=$1')
	sus=$(grep -A 3 '"last_analysis_stats"' $tmp | grep '"suspicious"' | awk '$1=$1')
	id=$(grep '"id"' $tmp | awk '$1=$1')
	echo "$id - $asown - $as - $cont - $count - $network - $rir - $harmful - $mal - $sus" >> completed
	# There is a sleep timer of 15 seconds because only 4 requests may be made to VirusTotal per minute with a public API key.
	sleep 15
done <"$file" 
rm /tmp/311d2d68-9c66-4db8-b10c-a28c0af0a3b9
echo "The script is now done"