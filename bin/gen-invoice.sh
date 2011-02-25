#!/bin/sh

GNUCASHFILE="/home/cougar/gc/version6net"
TEMPLATE="../examples/version6net.tex"
INVOICEDIR="/home/cougar/Doc/version6.net/arved"

if [ "$1" == "" ]
then
	echo "usage: $0 <invoice-id> [company]" >&2
	exit 1
fi

INVOICE="$1"
FILENAME="arve-$1"
[ "$2" != "" ] && FILENAME+="-$2"

echo "using filename $FILENAME"

cd ../lib
../bin/gc2latex $TEMPLATE $GNUCASHFILE $INVOICE > /tmp/${FILENAME}.tex
cd /tmp
texi2pdf ${FILENAME}.tex
if [ -e ${FILENAME}.pdf ]; then
	mv ${FILENAME}.pdf ${INVOICEDIR}/${FILENAME}.pdf
	echo "opening with arobat reader.."
	acroread ${INVOICEDIR}/${FILENAME}.pdf
else
	echo "something went wrong" >&2
	echo "filename was $FILENAME"
	exit 1
fi
