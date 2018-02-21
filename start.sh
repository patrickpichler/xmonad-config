start-pulseaudio-x11 & 

stalonetray &
nm-applet --sm-disable &

 # Start udiskie to handle media
udiskie --smart-tray &

 /home/patrick/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox --minimize &

sh /home/patrick/.fehbg

exec xmonad
