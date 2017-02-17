#!/usr/bin/env bash

if [ "$#" == "0" ]; then
    echo "Usage: `basename $0` PROJECT" >&2
    exit 1
fi

proj=$1
bin_dir=`dirname $(readlink -f $0)`

# Include config file
source $bin_dir/config

echo "Type h for help."

while true; do
    read -n 1 -p "> " input
    echo
    case $input in
	h)
	    cat <<EOF
c  take a picture
p  preview animation
r  render animation
q  quit
EOF
	    ;;
	c)
	    $bin_dir/click $proj
	    ;;
	p)
	    $bin_dir/preview $proj
	    ;;
	r)
	    $bin_dir/render $proj
	    ;;
	q)
	    exit 0
	    ;;
	*)
	    echo "Unknown command. Type h for help"
	    ;;
    esac
done

