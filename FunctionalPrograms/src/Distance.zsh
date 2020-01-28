#!/usr/bin/bash -x
#bash program to find the distance
source Utility.zsh
echo "enter the x value :"
read X
echo "enter the y value :"
read Y
val=$(distance $X $Y)
echo "$val"
