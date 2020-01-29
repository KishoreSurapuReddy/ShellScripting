#!/bin/bash -x

source Utility.zsh
echo "Tic-Tok-Toy"
echo "enter size of row :"
read row
echo "enter size of coloumn :"
read coloumn
currentPlayer="X"

#intialize the board with the size
intializeBoard(){
  Row=$1
  Coloumn=$2
  for (( row = 0; row < $Row; row++ ));
   do
    for (( col = 0; col < $Coloumn; col++ ));
     do
        board[$row,$col]="-"
    done
  done
}

#printing layouy of board
printBoard(){
  echo "board layout is :"
  echo "------------"
  for (( row = 0; row < $Row; row++ ));
    do
      echo  -e "| \c"
     for (( col = 0; col < $Coloumn; col++ ));
      do
         echo  -e " $row $col ${board[$row,$col]} | \c"
     done
     echo
     echo "------------"
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
  for (( row = 0; row < $Row; row++ ));
    do
     for (( col = 0; col < $Coloumn; col++ ));
      do
         if [  ${board[$row,$col]}   == '-' ];
          then
            return 1
         fi
     done
   done
   return 0
}

#checking wheather player has won or not
# shellcheck disable=SC2120
isWinner(){
 if checkRows || checkColoumns || checkDiagonals $1;then
   return 1
 else
   return 0
 fi
}

#method to check rows of table
# shellcheck disable=SC2120
checkRows(){
  for (( rows = 0; rows < ${#board[@]}; rows++ ));
   do
     if checkRowCol ${board[$rows,0]} ${board[$rows,1]} ${board[$rows,2]}  $1;
     then
       return 1
      else
        return 0
      fi
  done
}

#method to check coloumns of table
# shellcheck disable=SC2120
checkColoumns(){
   for (( cols = 0; cols < ${#board[@]}; cols++ ));
   do
     if checkRowCol ${board[0,$cols]} ${board[1,$cols]} ${board[2,$cols]}  $1;
     then
       return 1
      else
        return 0
      fi
  done
}

#method to check diagonals of table
checkDiagonals(){
  if checkRowCol ${board[0,0]} ${board[1,1]} ${board[2,2]} || checkRowCol ${board[0,2]} ${board[1,1]} ${board[2,0]} $1;
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
  row=$1
  col=$2
  echo ${#board[@]}
  if [[ (( $row -ge 0 )) && (( $row -lt ${#board[@]} )) ]]
  then
    echo "row $row"
   if [[ (( $col -ge 0 )) && (( $col -lt ${#board[@]} )) ]]
   then
    echo col $col
    if [ ${board[${row},${col}]} == "-" ]
    then
     board[$row,$col]=$currentPlayer
     echo  0 ${board[0]}
     echo 1 ${board[1]}
     echo 2 ${board[2]}
     echo  0 0 ${board[0, 0]}
     echo  0 1 ${board[0, 1]}
     echo  0 2 ${board[0, 2]}
     echo  1 0 ${board[1, 0]}
     echo  1 1 ${board[1, 1]}
     echo  1 2 ${board[1, 2]}
     echo  2 0 ${board[2, 0]}
     echo  2 1 ${board[2, 1]}
     echo  2 2 ${board[2, 2]}

     return 1
    fi
   fi
  fi
  return 0
}

#main
intializeBoard $row $coloumn
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
while [[ $(( !isBoardFull )) && $(( !isWinner )) ]];
do
printBoard
echo "player $currentPlayer place the mark at empty position "
echo "enter row position to insert:"
read rowposition
echo "enter col position to insert :"
read coloumnposition
#while [[ $(( !placeAMark $rowposition $coloumnposition )) ]];
#do
i=1;
if [ $i -eq 1 ];
then
placeAMark $rowposition $coloumnposition
changePlayer
#done
fi
done