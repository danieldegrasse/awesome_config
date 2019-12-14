#!/bin/bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

# first set the bell to something that is not the system beep
pactl upload-sample /usr/share/sounds/freedesktop/stereo/bell.oga x11-bell
pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY

# enable the keyring for secret storage
export $(gnome-keyring-daemon --start)

# enable policykit agent
run /usr/lib/mate-polkit/polkit-mate-authentication-agent-1

# start power manager
run mate-power-manager

# enable compositing
run picom -b

# run nextcloud for filesync
run nextcloud --background

