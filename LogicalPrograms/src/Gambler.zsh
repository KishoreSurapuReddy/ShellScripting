#!/usr/bin/bash -x
source Utility.zsh
echo "enter the intial amount :"
# shellcheck disable=SC2162
read intialamount
echo "enter the goal amount : "
read goal
gambler $intialamount $goal
