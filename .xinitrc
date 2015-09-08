#!/bin/bash

#uncomment for dual monitor support 
# xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --primary --mode 1920x1080 --right-of eDP1

export _JAVA_AWT_WM_NONREPARENTING=1
exec awesome
#exec ck-launch-session db-launch awesome
