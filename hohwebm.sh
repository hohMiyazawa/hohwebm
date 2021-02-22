#!/bin/bash
if hash aomenc 2>/dev/null; then
	echo ""
else
	echo "aomenc not fould. Did you install it?"
	echo "See 'installing aomenc'"
	exit
fi
if [ "$#" -eq 0 ] || [[ $1 == "--help" ]] || [[ $1 == "-help" ]]; then
	echo "usage:"
	echo "hohwebm.sh video [start [end [profile [...aom options]]]]"
	echo "example:"
	echo "hohwebm.sh anime\\ ep1.mkv 10:23 10:30.2 anilist"
	echo ""
	echo "  start          :  timestamp"
	echo "  end            :  timestamp"
	echo "  profile        :  predefined set of encoding parameters. Included: 'anilist', 'default', 'anilist_sound' and 'default_sound'"
	echo "  ...aom options :  every other option is passed to aomenc as a parameter. Overrides profile defaults."
	echo ""
	echo "Profiles"
	echo "  default: (selected if no profile provided) limit video to 720p for playback performance, but otherwise keep resolution"
	echo "  anilist: limit video to max 480 height or max 640 width, to fit nicely in an Anilist post"
	exit
fi
if [[ $1 == "--version" ]] || [[ $1 == "-version" ]]; then
	echo "hohwebm v0.1"
	echo "a tool for encoding short AV1 webms"
	exit
fi
profile=${4-default}
if [[ $profile == "anilist" ]]; then
	# likely to be animation, so --lag-in-frames=24
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale='min(640,iw)':'min(480,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=1 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=24 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=NUL
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale='min(640,iw)':'min(480,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=2 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=24 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output="$1"."$2"-"$3".webm
	rm tmp_hohlogfile.log
fi
if [[ $profile == "anilist_sound" ]]; then
	# likely to be animation, so --lag-in-frames=24
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale='min(640,iw)':'min(480,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=1 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=24 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=NUL
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale='min(640,iw)':'min(480,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=2 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=24 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=tmp_"$1"."$2"-"$3".webm
	rm tmp_hohlogfile.log
	ffmpeg -hide_banner -loglevel error -i "$1" -ss "$2" -to "$3" -strict -2 -b:a 96k tmp_hohaudio.opus
	ffmpeg -hide_banner -loglevel error -i tmp_"$1"."$2"-"$3".webm -i tmp_hohaudio.opus -c:v copy -c:a copy "$1"."$2"-"$3".webm
	rm tmp_"$1"."$2"-"$3".webm
	rm tmp_hohaudio.opus
fi
if [[ $profile == "default" ]]; then
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale=-1:'min(720,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=1 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=19 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=NUL
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale=-1:'min(720,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=2 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=19 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output="$1"."$2"-"$3".webm
	rm tmp_hohlogfile.log
fi
if [[ $profile == "default_sound" ]]; then
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale=-1:'min(720,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=1 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=19 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=NUL
	ffmpeg -hide_banner -loglevel error -y -i "$1" -vf "scale=-1:'min(720,ih)'" -ss "$2" -to "$3" -strict -1 -f yuv4mpegpipe - | aomenc - --passes=2 --pass=2 --threads=6 --cpu-used=4 --bit-depth=10 --tile-columns=1 --end-usage=q --lag-in-frames=19 --webm --cq-level=30 --fpf=tmp_hohlogfile.log --output=tmp_"$1"."$2"-"$3".webm
	rm tmp_hohlogfile.log
	ffmpeg -hide_banner -loglevel error -i "$1" -ss "$2" -to "$3" -strict -2 -b:a 96k tmp_hohaudio.opus
	ffmpeg -hide_banner -loglevel error -i tmp_"$1"."$2"-"$3".webm -i tmp_hohaudio.opus -c:v copy -c:a copy "$1"."$2"-"$3".webm
	rm tmp_"$1"."$2"-"$3".webm
	rm tmp_hohaudio.opus
fi
