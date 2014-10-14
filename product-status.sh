#!/bin/bash
#
# Checks if a SEARCHTERM exists in a given url,
# if the SEARCHTERM does not exist, sends email.
#
# Used for checking when products come back in stock
#
# Useage:
#    sh product-status.sh <PRODUCT NAME> <SEARCH TERM> <URL>
#
#############
# VARIABLES
#############

PRODUCT=$1
SEARCHTERM=$2
URL=$3
OUT=`wget -q -O - $URL | grep "$SEARCHTERM"`

############

if [ -z "$OUT" ]; then
	# In Stock! Sending Email
	echo "$URL" | mail -s "$PRODUCT is IN STOCK!" richarddowna@gmail.com
fi
