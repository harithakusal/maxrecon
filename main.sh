#!/bin/bash

echo "||||||||||||||||||||||"
echo "|||||| MAXRECON ||||||"
echo "||||||||||||||||||||||"
echo ""

echo "-----------------"
echo " Scanning domain "
echo "-----------------"

# check for empty string. Not zero file size. White spaces are allowed
if [ ! -z ./domains.txt ]; then
	while read line;
		do
			if [ $line ]; then
				echo $line
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
while read line;
	do
		if [ $line ]; then
			echo $line "| IP address saved to $line.txt"
			dig +short $line > $line.txt
		fi
done < ./domains.txt
echo ""



















