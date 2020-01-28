#!/usr/bin/bash -x

#this function is used to find the sumofintegers
function sumOfIntegers() {
    array=("$@")
    size="${#array[@]}"
    echo "${array[@]}"
    for (( first = 0; first < $size; first++ )); do
      for (( second = $first+1; second < $size; second++ )); do
        for (( third = $second+1; third < $size; third++ )); do
          (( sum=${array[first]}+${array[second]}+${array[third]} ))
            if [ $sum -eq 0 ]; then
                echo "${rray[first]} ${array[second]} ${array[third]} are the elments of array"
            fi
        done

      done

    done
}

#this method is used to find the distance
distance(){
  X=$1
  Y=$2
  echo "$X"
  echo "$Y"
  multiplicationx=$((X*X))
  multiplicationy=$((Y*Y))
  result=$((multiplicationx+multiplicationy))
  echo "$result"
  dist=$(echo "scale=3;sqrt($result)"|bc)
  echo $dist
}

#this method is used to find the quadratic equiation
quadraticEquiation(){
  A=$1
  B=$2
  C=$3
  echo "a and b and c values : $A $B $C"
  delta=$(( $((B*B))-$((4*A*C)) ))
  echo "$delta"
  squaredelta=$(echo "scale=2;sqrt($delta)"|bc)
  echo "$squaredelta"
  if [ $delta  -gt 0 ]; then
    rootone=$(echo "scale=3;$(( $((-B+squaredelta))/$((2*A)) ))"|bc)
    roottwo=$(( $((-B-squaredelta))/$((2*A)) ))
    echo "the roots are : $rootone and $roottwo "
  elif [ $delta -eq 0 ]; then
    # shellcheck disable=SC2017
    root=$((-B/2*A))
    echo "roots are $root"
  else
    echo "there are no roots"
  fi
}