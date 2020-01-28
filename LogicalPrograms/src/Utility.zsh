#!/usr/bin/bash -x

function gambler() {
    stack=$1
    goal=$2
    wins=0
    while [[ ( $stack -gt 0 ) && ( $stack -le $goal ) ]];
     do
      random=$(shuf -i 0-1 -n 1)
      echo $random
      if [ $random -eq 1 ]; then
        stack=`expr $stack+1`
        wins=`expr $wins+1`
      else
        stack=`expr $stack-1`
      fi
    done
}