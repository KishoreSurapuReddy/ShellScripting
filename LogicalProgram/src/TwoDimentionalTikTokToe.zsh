#!/bin/bash

source Utility.zsh
echo "Tic-Tok-Toy"
echo "enter size of row :"
read row
echo "enter size of coloumn :"
read coloumn
currentPlayer="X"
initialchar="-";
declare -A board

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
         echo  -e "${board[$row,$col]} | \c"
     done
     echo
     echo "------------"
   done
}

#changing player method
changePlayer(){
  if [ $currentPlayer == "X" ]; then
      currentPlayer="O"
  else
    currentPlayer="X"
  fi
}

#checking wheather board is full or not
isBoardFull(){
  for (( row = 0; row < $Row; row++ ));
    do
     for (( col = 0; col < $Coloumn; col++ ));
      do
         if [ ${board[$row,$col]} == $initialchar ];
          then
            return 1
         fi
     done
   done
   return 0
}

checkRowCol(){
  charone=$1
  chartwo=$2
  charthree=$3
  if [[ (( $charone != $initialchar )) && (( $charone == $chartwo )) && (( $chartwo == $charthree )) ]];
   then
    return 0
   else
    return 1
  fi
}

#method to check rows of table
# shellcheck disable=SC2120
checkRows(){
  for (( rows = 0; rows < ${#board[@]}; rows++ ));
   do
     checkRowCol ${board[$rows,0]} ${board[$rows,1]} ${board[$rows,2]}
     if [ $? -eq 1 ]; then
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
     checkRowCol ${board[0,$cols]} ${board[1,$cols]} ${board[2,$cols]}
     if [ $? -eq 1 ];
     then
       return 1
      else
        return 0
      fi
  done
}

#method to check diagonals of table
checkDiagonals(){
  checkRowCol ${board[0,0]} ${board[1,1]} ${board[2,2]}
  if [ $? -eq 1 ];
   then
     checkRowCol ${board[0,2]} ${board[1,1]} ${board[2,0]}
     if [ $? -eq 1 ]; then
         return 1
         else
           return 0
     fi
   else
     return 0
  fi
}

#checking wheather player has won or not
# shellcheck disable=SC2120
isWinner(){
  checkRows
 if [ $? -eq 1 ];
 then
   checkColoumns
    if [ $? -eq 1 ];
    then
      checkDiagonals
      if [ $? -eq 1 ];
      then
        return 1
        else
          return 0
      fi
    fi
  fi
  return 0
}

#method to place a mark at particular position
placeAMark(){
  row=$1
  col=$2
  echo ${#board[@]}
  if [[ ( $row -ge 0 ) && ( $row -lt ${#board[@]} ) ]];
  then
   if [[ ( $col -ge 0 ) && ( $col -lt ${#board[@]} ) ]];
   then
    if [ ${board[$row,$col]} == $initialchar ];
    then
     board[$row,$col]=$currentPlayer
     return 1
     else
       return 0
    fi
   fi
  fi
}

intializeBoard $row $coloumn
isBoardFull
if [ $? -eq 1 ];then
  echo "board is not full"
else
  echo "board is full"
fi
isWinner
if [ $? -eq 1 ];then
  echo "player hasn't won"
else
  echo "player has won"
fi
istrue=0;
until [ $istrue -eq 1 ];
do
  printBoard
  echo
  isBoardFull
  boardfull=$?
  isWinner
  winner=$?
  if [[ (boardfull -eq 1) && (winner -eq 1) ]]; then
    istrue=0
    else
      ((istrue++))
  fi
  isBoardFull
  if [ $? -eq 1 ];then
    echo "board is not full"
  else
    echo "board is full"
  fi
  isWinner
  if [ $? -eq 1 ];then
    echo "player hasn't won"
  else
    echo "player has won"
  fi
  echo "player $currentPlayer place the mark at empty position "
  echo "enter row value to insert:"
  read rowinsert
  echo "enter col value to insert :"
  read colinsert
  mark=0;
  until [ $mark -eq 1 ];
  do
    placeAMark $rowinsert $colinsert
    if [ $? -eq 1 ]; then
      changePlayer
      ((mark++))
      else
        echo "player $currentPlayer place the mark at empty position "
        echo "enter row value to insert:"
        read rowinsert
        echo "enter col value to insert :"
        read colinsert
        mark=0
    fi
  done
done