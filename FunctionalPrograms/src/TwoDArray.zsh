#!/usr/bin/bash -x
#bash program for twodimentional array
echo "enter row value :"
read Row
echo "enter coloumn value :"
read Col
declare -A twodarray
for (( row = 0; row < $Row; row++ )) do
  for (( col = 0; col < $Col; col++ )) do
    echo "enter numbers for twodarray :"
    read twodarray[${row},${col}]
  done
done
for (( row = 0; row < $Row; row++ )) do
  for (( col = 0; col < $Col; col++ )) do
    # shellcheck disable=SC2059
    printf "${twodarray[$row,$col]}\t"
  done
  echo
done