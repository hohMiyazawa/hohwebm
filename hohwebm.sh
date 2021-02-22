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
if [[ $4 == "anilist" ]]; then
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale='min(640,iw)':'min(480,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=1 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=24 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=NUL
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale='min(640,iw)':'min(480,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=2 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=24 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output="$1"."$2"-"$3".webm
	rm tmp_hohlogfile.log
fi
