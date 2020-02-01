#!/bin/bash

echo "Tic-Tok-Toy"
echo "enter size of array :"
read size
currentPlayer="X"
initialchar="-";
declare -A board

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
  if [ $currentPlayer == "X" ];
   then
    currentPlayer="O"
  else
   currentPlayer="X"
  fi
}

#checking wheather board is full or not
isBoardFull() {
  for (( index = 0; index < ${#board[@]}; index++ ))
    do
      # shellcheck disable=SC2053
      if [[ ${board[$index]} == $initialchar ]];
      then
        return 1
      fi
  done
  return 0
}

checkRowCol(){
  charone=$1
  chartwo=$2
  charthree=$3
  if [[ ($charone != $initialchar) && ($chartwo == $charone) && ($charthree == $chartwo) ]];
   then
    return 0
  else
    return 1
  fi
}

#method to check rows of table
checkRows(){
    positionone=0;
    positiontwo=1;
    positionthree=2;
        checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
        if [ $? -eq 1 ];
         then
           positionone=$(($positionone+3))
           positiontwo=$(($positiontwo+3))
           positionthree=$(($positionthree+3))
           checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
           if [ $? -eq 1 ];
           then
             positionone=$(($positionone+3))
             positiontwo=$(($positiontwo+3))
             positionthree=$(($positionthree+3))
             checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
             value=$?
             if [ $value -eq 1 ];
             then
               return 1
             else
               return 0
             fi
           else
            return 0
           fi
        else
          return 0
       fi
}

#method to check coloumns of table
checkColoumns(){
    positionone=0;
    positiontwo=3;
    positionthree=6;
        checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
        if [ $? -eq 1 ];
         then
            positionone=$(($positionone+1))
            positiontwo=$(($positiontwo+1))
            positionthree=$(($positionthree+1))
            checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
            if [ $? -eq 1 ];
              then
                positionone=$(($positionone+1))
                positiontwo=$(($positiontwo+1))
                positionthree=$(($positionthree+1))
                checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
                if [ $? -eq 1 ];
                  then
                    return 1
                  else
                    return 0
                fi
                else
                  return 0
            fi
            else
              return 0
        fi
}

#method to check diagonals of table
checkDiagonals(){
  checkRowCol ${board[0]} ${board[4]} ${board[8]}
  if [ $? -eq 1 ];
   then
     checkRowCol ${board[2]} ${board[4]} ${board[6]}
     if [ $? -eq 1 ];
      then
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
isWinner() {
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
     else
       return 0
   fi
   else
     return 0
 fi
}

#method to place a mark at particular position
placeAMark(){
  position=$1
  if [[ (( $position -ge 0 )) && (( $position -lt ${#board[@]} )) ]]
  then
    if [ ${board[${position}]} == "-" ]
    then
     board[$position]=$currentPlayer
     return 1
     else
      return 0
    fi
    else
     echo "enter position should be 0<position<9"
   fi
}

#main function
intializeBoard $size
istrue=0 ;
until [ $istrue -eq 1 ];
do
  isBoardFull
  boardfull=$?
  isWinner
  winner=$?
  if [[ ($boardfull -eq 1) && ($winner -eq 1) ]];
  then
    istrue=0
    else
      ((istrue++))
  fi
  if [[ ($boardfull -eq 1) || ($winner -eq 1) ]];
  then
    printBoard
    echo
    isBoardFull
    if [ $? -eq 1 ];
     then
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
    echo
    mark=0;
    until [ $mark -eq 1 ];
    do
    echo "player $currentPlayer place the mark at empty position "
    echo "enter empty position to insert:"
    read position
    placeAMark $position
    if [ $? -eq 1 ]; then
       changePlayer
       ((mark++))
    else
      mark=0
    fi
    done
  fi
done