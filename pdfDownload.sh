#!/bin/bash
i=0
while read varr
do
	((i++))
	curl $varr --output ${i}.pdf
done < pdfList.txt

