#!/bin/bash -x

echo "Tic-Tok-Toy"
echo "enter size of array :"
read size
currentPlayer="X"

#intialize the board with the size
intializeBoard(){
  length=$1
  for (( index = 0; index < $length; index++ ));
   do
    board[$index]="-"
  done
}

#printing layouy of board
printBoard(){
  echo "board layout is :"
  echo "------------"
  for (( index = 0; index < ${#board[@]}; index++ ));
    do
      echo  -e "| \c"
      if [ $index -lt 3 ]; then
          echo -e "${board[$index]} | \c"
      elif [ $index -lt 6 ]; then
          if [ $index -eq 3 ]; then
              echo
              echo -e "| \c"
          fi
          echo -e "${board[$index]} | \c"
          if [ $index -eq 6 ]; then
              echo
          fi
      else
         if [ $index -eq 6 ]; then
              echo
              echo -e "| \c"
         fi
        echo -e "${board[$index]} | \c"
      fi
   done
}

#changing player method
changePlayer(){
  if [ $currentPlayer == "X" ]; then
      currentPlayer="O"
      echo $currentPlayer
  else
    currentPlayer="X"
    echo $currentPlayer
  fi
}

#checking wheather board is full or not
isBoardFull(){
  for (( index = 0; index < ${#board[@]}; index++ ));
    do
      if [  ${board[$index]}   == '-' ];
      then
        # shellcheck disable=SC2152
        return 1
      fi
   done
   # shellcheck disable=SC2152
   return 0
}

#checking wheather player has won or not
# shellcheck disable=SC2120
isWinner(){
  checkDiagonals $1
 if ( checkRows || checkColoumns || $? );then
   # shellcheck disable=SC2152
   return 1
 else
   # shellcheck disable=SC2152
   return 0
 fi
}

#method to check rows of table
# shellcheck disable=SC2120
checkRows(){
    nooftimes=0;
    positionone=0;
    positiontwo=1;
    positionthree=2;
    while [ $nooftimes -lt 3 ]; do
        echo "row $positionone"
        echo "row1 $positiontwo"
        echo "row $positionthree"
        if checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}  $1;
    then
      return 1
    else
      return 0
    fi
    positionone=$($positionone+3)
    positiontwo=$($positiontwo+3)
    positionthree=$($positionthree+3)
    nooftimes=$($nooftimes+1)
    done
}

#method to check coloumns of table
# shellcheck disable=SC2120
checkColoumns(){
    nooftimes=0;
    positionone=0;
    positiontwo=3;
    positionthree=6;
    while [ $nooftimes -lt 3 ]; do
        echo "coloumn $positionone"
        echo "coloumn $positiontwo"
        echo "coloumn $positionthree"
        if checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}  $1;
    then
      return 1
    else
      return 0
    fi
    positionone=$($positionone+1)
    positiontwo=$($positiontwo+1)
    positionthree=$($positionthree+1)
    nooftimes=$($nooftimes+1)
    done
}

#method to check diagonals of table
checkDiagonals(){
  if checkRowCol ${board[0]} ${board[4]} ${board[8]} || checkRowCol ${board[2]} ${board[4]} ${board[6]} $1;
   then
     return 1
   else
     return 0
  fi
}

checkRowCol(){
  charone=$1
  chartwo=$2
  charthree=$3
  # shellcheck disable=SC2053
  if [[ ((( $charone == "-" )) && (( $charone == $chartwo )) && (( $chartwo == $charthree ))) ]];
   then
    return 1
   else
    return 0
  fi
}

#method to place a mark at particular position
placeAMark(){
  position=$1
  echo ${#board[@]}
  if [[ (( $position -ge 0 )) && (( $position -lt ${#board[@]} )) ]]
  then
    echo $position
    if [ ${board[${position}]} == "-" ]
    then
     # shellcheck disable=SC2102
     board[$position]=$currentPlayer
     return 1
    fi
   fi
  return 0
}

#main
intializeBoard $size
if isBoardFull  $1;then
  echo "board is full"
else
  echo "board is not full"
fi
if isWinner $1;then
  echo "player has won"
else
  echo "player hasn't won"
fi
# shellcheck disable=SC1035
isboardfull=isBoardFull
echo $val
echo $isWinner
while [[ $(( !isBoardFull )) || $(( !isWinner )) ]];
do
printBoard
echo
echo "player $currentPlayer place the mark at empty position "
echo "enter empty position to insert:"
read position
#while [[ $(( !placeAMark $position )) ]];
#do
i=1;
if [ $i -eq 1 ];
then
placeAMark $position
changePlayer
#done
fi
done