#! /bin/bash

PLANSZA=(. . . . . . . . .)
GRACZ=1
STATUS_GRY=1

function WYSWIETL {
   echo "y\x 0 1 2"
   echo "0   ${PLANSZA[0]} ${PLANSZA[1]} ${PLANSZA[2]}"
   echo "1   ${PLANSZA[3]} ${PLANSZA[4]} ${PLANSZA[5]}"
   echo "2   ${PLANSZA[6]} ${PLANSZA[7]} ${PLANSZA[8]}"
}

function RUCH {
   POLE=$(( $1 * 3 + $2 ))
   if [ ${PLANSZA[$POLE]} == "." ]; then 
      PLANSZA[$POLE]=$3
      GRACZ=$((GRACZ%2+1))
   else
      echo "Pole juz jest zajete!"
   fi
}

function SPRAWDZ_RUCH {
   if [ ${PLANSZA[$1]} != "." ] && [ ${PLANSZA[$1]} == ${PLANSZA[$2]} ] && [ ${PLANSZA[$2]} == ${PLANSZA[$3]} ]; then
      STATUS_GRY=0
   fi
}

function SPRAWDZ_STATUS_GRY {
   SPRAWDZ_RUCH 0 1 2
   SPRAWDZ_RUCH 3 4 5
   SPRAWDZ_RUCH 6 7 8
   SPRAWDZ_RUCH 0 3 6
   SPRAWDZ_RUCH 1 4 7
   SPRAWDZ_RUCH 2 5 8
   SPRAWDZ_RUCH 0 4 8
   SPRAWDZ_RUCH 2 4 6
}

while [ 1 ]; do
   echo ""
   if [ $GRACZ == 1 ]; then SYMBOL=O
   else SYMBOL=X; fi
   echo "Ruch gracza $GRACZ ($SYMBOL) :"
   WYSWIETL
   echo ""
   echo "-=-  Wykonaj  ruch  -=-"
   echo "> pole [x] [y]"
   echo "-----------------------"
   while [ 1 ]; do
      read -r cmd a b
      if [ $cmd == "pole" ] && [ $a -ge 0 ] && [ $a -le 2 ] && [ $b -ge 0 ] && [ $b -le 2 ]; then
  	RUCH $b $a $SYMBOL
	break
      else
	echo "Nieprawidłowa komenda!"
      fi
   done
   SPRAWDZ_STATUS_GRY
   if [ $STATUS_GRY != 1 ]; then
      echo "-=- Koniec gry -=-"
      GRACZ=$((GRACZ%2+1))
      echo "Gracz $GRACZ ($SYMBOL) wygrywa!"
      break
   fi
done