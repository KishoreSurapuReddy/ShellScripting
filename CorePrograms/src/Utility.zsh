#!/bin/bash -x
#funtion to implement flipacoin
function flipACoin(){
  number=$1
  Heads=0
  Tails=0
  # shellcheck disable=SC2004
  for (( flip=0; flip<$number; flip++))
  do
    randomvalue=$(($RANDOM%2))
  echo " the random $randomvalue"
  if (( $randomvalue>=1 ))
  then
    Heads=$(($Heads+1))
  else
    Tails=$(($Tails+1))
  fi
  done
  echo "$Heads"
  echo "$Tails"
  # shellcheck disable=SC2004
  headpercentage=$(( 100*$Heads/$number ))
  tailpercentage=$(( 100*$Tails/$number ))
  echo "the percentage of heads : $headpercentage"
  echo "the percentage of tails : $tailpercentage"
  }

#this method used find leap year
leapYear()
{
Year=$1
if (( ($Year % 4) == 0  ||  ($Year % 400) == 0 ))
then
echo "enter $Year is leap year."
else
echo "enter $Year is non leap year"
fi
}

#this method used find the power of two
powerOfTwo(){
  Number=$1
  Power=$2
  count=1
  for (( index = 0; index < $Power; index++ )); do
      count=$(($count*$Number))
      echo "$count"
  done
  echo "$count"
}

#this method is used to find harmonic number
harmonicNumber(){
  Number=$1
  count=0
  result=0
  for (( loop = 1; loop <= $Number; loop++ )); do
    count=$count+1/$loop
    result=$count
  done
  echo "$result"
}

#this method is used find the primefactors of number
primeFactor(){
  Number=$1
  for (( loop = 2; loop <= $Number; loop++ )); do
    if (( $(( Number%$loop )) == 0 ))
      then
        echo "factors are :$loop"
        Number=`expr $(( Number/$loop ))`
    fi
  done
}
