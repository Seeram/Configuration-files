#!/bin/sh

xmodmap ~/.config/caps_esc_swap
xrdb -merge ~/.Xresources

exec i3
