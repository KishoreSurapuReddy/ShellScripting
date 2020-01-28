#!/usr/bin/bash -x

#this method is used to find the player winning percentage
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

#this method is used generate couponcodes
couponCodeGenerator(){
  couponcode=$1
  echo $couponcode
  length=5
  echo $length
  declare -a couponarray
  couponstring=""
  echo ${#couponcode}
  echo "enter how many coupons required :"
  read noOfCoupons
  for (( coupons = 0; coupons < $noOfCoupons; coupons++ ));
   do
    for (( index=0; index < $length; index++ ));
     do
      random=$(shuf -i 0-22 -n 1)
      coupchar=${couponcode:$random:1}
      couponstring=$couponstring$coupchar
      #couponarray[$coupons]=$couponstring
     done
     couponarray[$coupons]=$couponstring
   done
  echo "coupon code is :${couponarray[*]} "
}