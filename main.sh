#!/bin/bash

echo "||||||||||||||||||||||"
echo "|||||| MAXRECON ||||||"
echo "||||||||||||||||||||||"
echo ""

# START: dig

echo "-----------------"
echo " Scanning domain "
echo "-----------------"

# check for empty string. Not zero file size. White spaces are allowed
if [ ! -z ./domains.txt ]; then
	while read domain;
		do
			#  ignore empty lines
			if [ $domain ]; then
				echo $domain
			fi
	done < ./domains.txt
else
	echo "No domains found. File is empty or doesn't exist."
	echo ""
	exit
fi

echo ""
echo "---------------------"
echo " Scanning IP address "
echo "---------------------"
while read domain;
	do
		if [ $domain ]; then
			echo $domain "| IP address saved to dig.$domain.ip"
			dig +short $domain > dig.$domain.ip
		fi
done < ./domains.txt
echo ""

# END: dig

# START: masscan

echo "----------------"
echo " Scanning ports "
echo "----------------"

ls ./ > fileNames.txt

while read filename;
	do
		if [ $filename=="dig.$domain.ip" ] && [ ! -z ./dig.$domain.ip ]; then
        		while read domain;
                		do
                        		if [ $domain ]; then
						while read ip;
							do
				                		if [ $ip ]; then
				                        		echo "Scanning $ip from $domain"
                        						sudo masscan -p80 $ip --rate=1000
                        						echo "Scan successfull | Ports saved to masscan.$ip.txt"
									echo ""
                						fi
						done < $filename
                        		fi
        		done < ./domains.txt
		else
        		echo "No IPs found. File is empty or doesn't exist."
        		echo ""
        		exit
		fi
done <  ./fileNames.txt

# END: masscan


















