#!/usr/bin/bash -x
#bash program to find the sumofintegers
source Utility.zsh
echo "enter the size of array :"
read size
declare -a arrayOfNumbers   #(1 2 0 1 0 0 5 0 0 2)
echo "enter the elemnts into array :"
for (( index = 0; index < $size; index++ ));
 do
  read arrayOfNumbers[${index}]
done
#shellcheck disable=SC1063
for value in "${arrayOfNumbers[@]}"
do
  echo $value
done
sumOfIntegers "${arrayOfNumbers[@]}"

