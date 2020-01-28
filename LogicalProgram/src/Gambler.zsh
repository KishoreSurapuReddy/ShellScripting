#!/usr/bin/bash -x
#bash program to find the winning percentage of player
source Utility.zsh
echo "enter the intial amount :"
# shellcheck disable=SC2162
read intialamount
echo "enter the goal amount : "
read goal
gambler $intialamount $goal