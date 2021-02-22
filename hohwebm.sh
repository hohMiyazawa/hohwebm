#!/bin/bash
if [ "$#" -eq 0 ] || [[ $1 == "--help" ]] || [[ $1 == "-help" ]]; then
	echo "usage:"
	echo "hohwebm.sh video [start [end [profile [...aom options]]]]"
	echo "example:"
	echo "hohwebm.sh anime\\ ep1.mkv 10:23 10:30.2 anilist"
	echo ""
	echo "  start          :  timestamp"
	echo "  end            :  timestamp"
	echo "  profile        :  predefined set of encoding parameters. Included: 'anilist', 'anilist-slow', 'anilist-fast' and 'default'"
	echo "  ...aom options :  every other option is passed to aomenc as a parameter. Overrides profile defaults."
	exit
fi
if [[ $1 == "--version" ]] || [[ $1 == "-version" ]]; then
	echo "hohwebm v0.1"
	echo "a tool for encoding short AV1 webms"
	exit
fi
