#!/usr/bin/env sh
intern=eDP-1
extern=VIRTUAL4

# Terminate already running bar instances
killall -q intel-virtual-output
# Wait until the processes have been shut down
while pgrep -x intel-virtual-output >/dev/null; do sleep 1; done

intel-virtual-output
sleep 10

if xrandr | grep "$extern disconnected"; then
    # Terminate already running bar instances
    killall -q intel-virtual-output
    # Wait until the processes have been shut down
    while pgrep -x intel-virtual-output >/dev/null; do sleep 1; done
    xrandr --output "$intern" --auto
    echo "Disconnecting"
else
    xrandr --output "$extern" --auto --right-of "$intern"
    echo "Connecting"
fi

i3-msg restart
