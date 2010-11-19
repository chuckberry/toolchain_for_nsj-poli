#!/bin/bash

function print_usage {
cat - <<EOF

$1 --> suffix folder (15000-sel-cp for ex.)

EOF
}

SUFFIX=$1

if [ x$SUFFIX == "x" ]; then
	print_usage
	exit 1;
fi

if [ ! -d bmarks ]; then
	echo "bmarks not found"
	exit 1;
fi

if [ ! -f last_bmarks.log ]; then
	echo "last_bmarks.log not found"
	exit 1;
fi

if [ ! -d bmarks-$SUFFIX ]; then
	echo "bmarks-$SUFFIX not exist"
	exit 1;
fi

LAST_SUFFIX=`cat last_bmarks.log | tail -n 1 | awk '{print $1}'`

mv bmarks bmarks-$LAST_SUFFIX
mv bmarks-$SUFFIX bmarks
echo "$SUFFIX --> `date`" >> last_bmarks.log
