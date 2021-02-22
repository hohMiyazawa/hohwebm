Skoll3 managed to get AV1 into mpv-webm, so that's probably easier to use: https://github.com/hohMiyazawa/Skoll3webm

# hohwebm (work in progress)
AV1 webms with less headache

A bash script for encoding AV1 clips

# Requirements
- ffmpeg (sudo apt install ffmpeg)
- aomenc (see 'installing aomenc')

# Install

Place in PATH, for instance in:
```
sudo cp hohwebm.sh /usr/local/bin/hohwebm.sh
```

# Usage

```
hohwebm.sh video [start [end [profile [...aom options]]]]
```
example:  
```
hohwebm.sh anime\ ep1.mkv 10:23 10:30.2 anilist
```

parameters:  
```
  start          :  timestamp (hint: mpv gives you decimal seconds if you click on the time)
  end            :  timestamp
  profile        :  predefined set of encoding parameters. Included: 'anilist', 'default', 'anilist_sound' and 'default_sound'"
  ...aom options :  every other option is passed to aomenc as a parameter. Overrides profile defaults.
```

# Advanced

Useful aom flags:
```
--cq-level=30
```
Quality←→size tradeoff, 0-63, 30 is the default. Higher means smaller files, lower quality, smaller means larger files, higher quality.

```
--cpu-used=4
```
Speed←→size tradeoff, 0-6, 4 is the default. Higher means faster encoding, larges files, smaller means slower encoding, smaller files.


# Limitations

- No subtitles (TODO)
