#!/bin/bash

USER=zack
SHELL=bash

sed -i "s/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g" /etc/sudoers

useradd -m -G wheel -s /bin/${SHELL} ${USER}
passwd ${USER}

# If you want to add additional window managers as options or specify a specific one
# to launch from lightDM, a desktop entry needs to be made for them at:
#
# /usr/share/xsessions/
#
# More info can be found at:
#
# https://wiki.archlinux.org/index.php/Display_manager#Session_configuration

# To configure your monitor or multiple monitors further, take a look at:
#
# https://wiki.archlinux.org/index.php/Xrandr#Configuration
#
# In order to generate a Modeline, enter something like "cvt 2560 1440 144"
# to get a result for width, height, and refresh rate respectively
#
# Example 10-monitor.conf file provided to be placed in /etc/X11/xorg.conf.d/
