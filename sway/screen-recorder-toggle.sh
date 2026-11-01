#!/bin/sh

if pgrep -x wf-recorder > /dev/null; then
    pkill -SIGINT wf-recorder
else
    wf-recorder -r 60 -c libx264 -a \
        -f "$HOME/Videos/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4" &
fi   
