#!/bin/sh
# Toggle a wf-recorder screen recording.
#   start: on-screen 3-2-1 countdown (dunst), then record
#   stop:  wait for the file to be finalised, then notify where it was saved
#   press again during the countdown to cancel

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}"
COUNTDOWN_PID="$STATE_DIR/screen-recorder.countdown.pid"
LAST_FILE="$STATE_DIR/screen-recorder.last"
NOTIFY_ID=9137
ICON="camera-video"

# Stop a running recording
if pgrep -x wf-recorder > /dev/null; then
    pkill -SIGINT -x wf-recorder
    # wf-recorder needs a moment to flush and close the file
    for _ in $(seq 1 100); do
        pgrep -x wf-recorder > /dev/null || break
        sleep 0.1
    done
    file=$(cat "$LAST_FILE" 2>/dev/null)
    dunstify -r "$NOTIFY_ID" -t 5000 -i "$ICON" "Recording ended" "${file:+Saved to ${file##*/}}"
    exit 0
fi

# Cancel a countdown that is in progress
if [ -f "$COUNTDOWN_PID" ] && kill -0 "$(cat "$COUNTDOWN_PID")" 2>/dev/null; then
    kill "$(cat "$COUNTDOWN_PID")"
    rm -f "$COUNTDOWN_PID"
    dunstify -r "$NOTIFY_ID" -t 2500 -i "$ICON" "Recording cancelled"
    exit 0
fi

echo $$ > "$COUNTDOWN_PID"
for n in 3 2 1; do
    dunstify -r "$NOTIFY_ID" -t 1200 -i "$ICON" "Recording starts in" \
        "<span size='xx-large'><b>$n</b></span>"
    sleep 1
done
rm -f "$COUNTDOWN_PID"

# Close the countdown so it isn't captured in the video
dunstify -C "$NOTIFY_ID"
sleep 0.3

file="$HOME/Videos/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
echo "$file" > "$LAST_FILE"
exec wf-recorder -r 60 -c libx264 -a -f "$file"
