#!/bin/bash
PRODUCT="Laphroaig Quater Cask"
URL="https://www.whiskyandmore.co.nz/single-malt-whisky-for-sale/buy-laphroaig-quarter-cask-islay-single-malt-201-online/"
OUT=`wget -q -O - $URL | grep "Sold out!"`
if [ -z "$OUT" ]; then
	# In Stock! Sending Email
	echo "$URL" | mail -s "$PRODUCT is IN STOCK!" richarddowna@gmail.com
fi
