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
    echo $currentPlayer
  else
   currentPlayer="X"
   echo $currentPlayer
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
  #echo $charone "checkrowcol character1"
  #echo $chartwo  "checkrowcol character2"
  #echo $charthree "checkrowcol character3"
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
        #echo "row $positionone"
        #cho "row1 $positiontwo"
        #echo "row $positionthree"
        checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
       # echo $?"checkrowcol value row1"
        if [ $? -eq 1 ];
        #echo "row valiue :$?"
         then
           positionone=$(($positionone+3))
           positiontwo=$(($positiontwo+3))
           positionthree=$(($positionthree+3))
           #echo "row $positionone"
           #echo "row1 $positiontwo"
           #echo "row $positionthree"
           checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
#           echo $?"checkrowcol value row2"
           if [ $? -eq 1 ];
           then
             positionone=$(($positionone+3))
             positiontwo=$(($positiontwo+3))
             positionthree=$(($positionthree+3))
             #echo "row $positionone"
             #echo "row1 $positiontwo"
             #echo "row $positionthree"
             checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
             value=$?
#             echo $value"checkrowcol value row3"
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
        #echo "coloumn $positionone"
        #echo "coloumn $positiontwo"
        #echo "coloumn $positionthree"
        checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
#        echo $?"checkrowcol value coloumn1"
        if [ $? -eq 1 ];
         then
            positionone=$(($positionone+1))
            positiontwo=$(($positiontwo+1))
            positionthree=$(($positionthree+1))
            checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
#            echo $?"checkrowcol value coloumn2"
            if [ $? -eq 1 ];
              then
                positionone=$(($positionone+1))
                positiontwo=$(($positiontwo+1))
                positionthree=$(($positionthree+1))
                checkRowCol ${board[$positionone]} ${board[$positiontwo]} ${board[$positionthree]}
#                echo $?"checkrowcol value coloumn3"
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
#  echo $?"checkrowcol value diagonal1"
  if [ $? -eq 1 ];
   then
     checkRowCol ${board[2]} ${board[4]} ${board[6]}
#     echo $?"checkrowcol value diagonal2"
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
 #echo $?"checkrowcol value rows"
 then
   checkColoumns
   if [ $? -eq 1 ];
  # echo $?"checkrowcol value coloumns"
   then
     checkDiagonals
     if [ $? -eq 1 ];
   #  echo $?"checkrowcol value diagonals"
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
  echo ${#board[@]}
  if [[ (( $position -ge 0 )) && (( $position -lt ${#board[@]} )) ]]
  then
    echo $position
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

#main
intializeBoard $size
isBoardFull
if [ $? -eq 1 ] ;
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
#echo isBoardFull $? "method returing something or not"
length=0
while [[ $length -le 11 ]];
do
  isBoardFull
  boardfull=$?
  echo $boardfull" boardfull or not"
  isWinner
  winner=$?
  echo $winner" winner or not "
  if [[ ($boardfull -eq 1) || ($winner -eq 1) ]];
   then
     printBoard
     echo
     isBoardFull
     if [ $? -eq 1 ] ;
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
    echo "player $currentPlayer place the mark at empty position "
    echo "enter empty position to insert:"
    read position
    #while [ true ];
    #do
    i=1;
    if [ $i -eq 1 ];
    then
    placeAMark $position
    changePlayer
    #done
    fi
  fi
  length=$(($length+1))
done