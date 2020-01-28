#!/usr/bin/bash -x

function gambler() {
    stack=$1
    goal=$2
    wins=0
    noOfTimes=0
    while [[ ( $stack -gt 0 ) && ( $stack -le $goal ) ]];
     do
      random=$(shuf -i 0-1 -n 1)
      #echo $random
      if [ $random -eq 1 ]; then
        stack=$((stack+1))
        wins=$((wins+1))
      else
        stack=$((stack-1))
      fi
      noOfTimes=$((noOfTime+1))
    done
    echo $stack
    echo $wins
    echo "player $wins of $noOfTimes times"
    winpercentage=$((100*(wins/noOfTimes)))
    echo "winning percentage of player is : $winpercentage"
}