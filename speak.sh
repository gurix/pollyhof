#!/bin/sh

AUDIO_PLAYER=afplay
VOICE=Hans

# create the output directory if not exists
mkdir -p output

# Extract filename
filename=`basename $1 .slim`

# Slimify file
slimrb $1 -p > output/$filename.ssml

# Synthesize the content
aws polly synthesize-speech \
--text-type ssml \
--text "`slimrb $1 -p`" \
--output-format mp3 \
--voice-id $VOICE \
output/$filename.mp3

# Play it
$AUDIO_PLAYER output/$filename.mp3 