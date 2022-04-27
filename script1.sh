#!/bin/bash
ERRORES=/home/errores.txt
LISTA=/home/lista.txt
df -h
cd /
if [ -f $ERRORES && -f $LISTA ]; then
	echo -e "\nLos directorios que mas ocupan son:\n "

else
	echo -e "\nLos directorios que mas ocupan son:\n "
	touch $ERRORES
	touch $LISTA
fi

du -hs * 2> $ERRORES | sort -rh | head -5
echo -e "\n"
read -p "Introduce la carpeta que deseas analizar ( 0 si no quieres seguir analizando, -1 para volver atras)" CARPETAS
echo -e "\n"


du -hs * 2> $ERRORES | sort -rh | head -5 > $LISTA
SUB1=$( sed -n "$CARPETAS"p $LISTA | awk '{print $2}')

du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 
du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 > $LISTA

echo -e "\n"
read -p "Introduce la carpeta que deseas analizar ( 0 si no quieres seguir analizando, -1 para volver atras)" CARPETAS
echo -e "\n"
while [ $CARPETAS -ne 0 ]
do
	if [ $CARPETAS -eq -1 ]; then
		SUB1=$(echo $SUB1 | cut -d "/" -f 1)
		cd $SUB1
		SUB1=$(pwd)
		du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 
                du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 > $LISTA
		echo -e "\n"
		read -p "Introduce la carpeta que deseas analizar ( 0 si no quieres seguir analizando, -1 para volver atras)" CARPETAS
		echo -e "\n"
		while [ $CARPETAS -eq -1 ]
		do
			cd $SUB1 ; cd ..
			SUB1=$(pwd)
			if [ $SUB1 == "/" ]; then
				du -hs * 2> $ERRORES | sort -rh | head -5
				du -hs * 2> $ERRORES | sort -rh | head -5 > $LISTA
				echo -e "\n"
				read -p "Introduce la carpeta que deseas analizar ( 0 si no quieres seguir analizando, -1 para volver atras)" CARPETAS
				echo -e "\n"
			else
				echo $SUB1
	               		du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3
        	        	du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 > $LISTA
                		echo -e "\n"
				read -p "Introduce la carpeta que deseas analizar ( 0 si no quieres seguir analizando, -1 para volver atras)" CARPETAS
				echo -e "\n"
			fi
		done

	else
		SUB1=$(sed -n "$CARPETAS"p $LISTA | awk '{print $2}')
        	du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 
        	du -hs "$SUB1"/* 2> $ERRORES | sort -rh | head -3 > $LISTA
		echo -e "\n"
		read -p "Introduce la carpeta que deseas analizar ( 0 si no quieres seguir analizando, -1 para volver atras)" CARPETAS
		echo -e "\n"

	fi
done

